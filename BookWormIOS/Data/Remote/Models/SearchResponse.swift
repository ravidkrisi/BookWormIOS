//
//  SearchResponse.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 24/06/2025.
//

import Foundation

protocol ToBook {
    func toBook(coverImageURL: URL?) -> Book
}

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let numFound, start: Int?
    let numFoundExact: Bool?
    let searchResponseNumFound: Int?
    let documentationURL: String?
    let q: String?
    let docs: [SearchBook]?

    enum CodingKeys: String, CodingKey {
        case numFound, start, numFoundExact
        case searchResponseNumFound = "num_found"
        case documentationURL = "documentation_url"
        case q, docs
    }
}

// MARK: - bookModel
struct SearchBook: Codable, ToBook {
    func toBook(coverImageURL: URL?) -> Book {
        Book(id: key ?? UUID().uuidString, title: title, author: authorName?.first ?? "", coverImageURL: coverImageURL)
    }
    
    
    
    let authorKey, authorName: [String]?
    let coverEditionKey: String?
    let coverI: Int?
    let ebookAccess: String?
    let editionCount, firstPublishYear: Int?
    let hasFulltext: Bool?
    let ia: [String]?
    let iaCollectionS, key: String?
    let language: [String]?
    let lendingEditionS, lendingIdentifierS: String?
    let publicScanB: Bool?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case authorKey = "author_key"
        case authorName = "author_name"
        case coverEditionKey = "cover_edition_key"
        case coverI = "cover_i"
        case ebookAccess = "ebook_access"
        case editionCount = "edition_count"
        case firstPublishYear = "first_publish_year"
        case hasFulltext = "has_fulltext"
        case ia
        case iaCollectionS = "ia_collection_s"
        case key, language
        case lendingEditionS = "lending_edition_s"
        case lendingIdentifierS = "lending_identifier_s"
        case publicScanB = "public_scan_b"
        case title
    }
}
