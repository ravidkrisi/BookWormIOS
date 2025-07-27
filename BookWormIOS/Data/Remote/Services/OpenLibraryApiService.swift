//
//  OpenLibraryApiService.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 22/06/2025.
//

import Foundation
import Combine

protocol BooksRemoteRepo {
    func fetchBooksByQuery(_ name: String) -> AnyPublisher<[Book], Error>?
    func getBookCoverUrl(for coverI: Int?) -> URL?
    func fetchBooksByList(_ list: String) -> AnyPublisher<[Book], Error>?
}

class OpenLibraryApiService: BooksRemoteRepo {
    
    // MARK: - protocol implementation
    
    /// fetch books from API by query
    /// - Parameter query: query for search such as book name, author..
    /// - Returns: publisher of array of books
    func fetchBooksByQuery(_ query: String) -> AnyPublisher<[Book], Error>? {
        // create query url
        guard let url = createSearchURL(for: query) else {
            return nil
        }
        
        // api response publisher
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .decode(type: SearchResponse.self, decoder: JSONDecoder())
            .map { $0.docs ?? [] as [SearchBook] }
            .map({ bookModels in
                bookModels.map { [weak self] bookModel in
                    let coverURL = self?.getBookCoverUrl(for: bookModel.coverI)
                    return bookModel.toBook(coverImageURL: coverURL)
                }
            })
            .eraseToAnyPublisher()
    }
    
    /// fetch books by list
    /// - Parameter list: list name
    /// - Returns: publisher of books
    func fetchBooksByList(_ list: String) -> AnyPublisher<[Book], Error>? {
        guard let url = createListURL(for: list) else {
            return nil
        }

        // api response publisher
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .decode(type: ListResponse.self, decoder: JSONDecoder())
            .map { $0.works ?? [] as [ListBook] }
            .map({ bookListModels in
                bookListModels.map { [weak self] bookListModel in
                    let coverURL = self?.getBookCoverUrl(for: bookListModel.coverI)
                    return bookListModel.toBook(coverImageURL: coverURL)
                }
            })
            .eraseToAnyPublisher()
    }



    
    /// create url for book cover
    /// - Parameter book: book
    /// - Returns: `URL?`
    func getBookCoverUrl(for coverI: Int?) -> URL? {
        guard let coverI = coverI else { return nil }
        return URL(string: "https://covers.openlibrary.org/b/id/\(coverI)-L.jpg")
    }
    
    // MARK: - helper methods
    /// generate search URL
    /// - Parameter query: query for search
    /// - Returns: `URL?` for the api request
    private func createSearchURL(for query: String) -> URL? {
        var components = URLComponents(string: "https://openlibrary.org/search.json")
        components?.queryItems = [
            URLQueryItem(name: "q", value: query)
        ]
        return components?.url
    }
    
    /// generate list URL
    /// - Parameter list: list name
    /// - Returns: URL
    private func createListURL(for list: String) -> URL? {
        return URL(string: "https://openlibrary.org/trending/\(list).json")
    }
    
    
}
