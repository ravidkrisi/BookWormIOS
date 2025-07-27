//
//  FirestoreBooksService.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 27/06/2025.
//

import Foundation

protocol BooksLocalRepo {
    func addBook(uid: String, book: Book) async throws
    func updateBookStatus(uid: String, book: Book, status: BookStatus) async throws
    func getUsersBook(uid: String, bookId: String) async throws -> Book?
    func getAllUserBooks(uid: String) async throws -> [Book]
}

class FirestoreBooksService: BooksLocalRepo {
    
    private let usersService: UsersLocalRepo
    private let booksCollection = "books"
    
    init(usersDBservice: UsersLocalRepo) {
        self.usersService = usersDBservice
    }
    
    // MARK: - Protocol Implementation
    
    /// get book model of a book
    /// - Parameters:
    ///   - uid: user id
    ///   - bookId: book id
    /// - Returns: book  if exists else nil
    func getUsersBook(uid: String, bookId: String) async throws -> Book? {
            let safeID = bookId
                .trimmingCharacters(in: CharacterSet(charactersIn: "/"))
                .replacingOccurrences(of: "/", with: "_")

            let snapshot = try await usersService.userDocument(id: uid)
                .collection(booksCollection)
                .document(safeID)
                .getDocument()

            return try snapshot.data(as: Book.self)
        }
    
    
    /// update book status for user
    /// - Parameters:
    ///   - uid: user id
    ///   - book: book
    ///   - status: book status
    func updateBookStatus(uid: String,
                          book: Book,
                          status: BookStatus) async throws {
        
        
        let updatedBook = book.with(status: status)
        
        try usersService.userDocument(id: uid)
            .collection(booksCollection)
            .document(updatedBook.docID)
            .setData(from: updatedBook, merge: true)
        print("updated status")
    }
    
    /// add book to user books collection
    /// - Parameters:
    ///   - uid: user id
    ///   - book: book
    func addBook(uid: String, book: Book) async throws {
        let userDoc = usersService.userDocument(id: uid)
        
        do {
            try userDoc.collection(booksCollection).document(book.id).setData(from: book)
        } catch {
            print("failed to add book")
        }
    }
    
    /// get all user's book collection
    /// - Parameter uid: user id
    /// - Returns: books array
    func getAllUserBooks(uid: String) async throws -> [Book] {
            let docs = try await usersService.userDocument(id: uid)
                .collection(booksCollection)
                .getDocuments()
                .documents
            
            // Decode every doc into Book; ignore any that fail to decode
            return docs.compactMap { try? $0.data(as: Book.self) }
        }
}
