//
//  BookModel.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 22/06/2025.
//

// MARK: SEARCH API RESPOSNE EXAMPLE
/*
 SEARCH OPENLIBRARY API RESPONSE
 {
 "numFound": 812,
 "start": 0,
 "numFoundExact": true,
 "num_found": 812,
 "documentation_url": "https://openlibrary.org/dev/docs/api/search",
 "q": "the lord of the rings",
 "offset": null,
 "docs": [
 {
 "author_key": [
 "OL26320A"
 ],
 "author_name": [
 "J.R.R. Tolkien"
 ],
 "cover_edition_key": "OL51694024M",
 "cover_i": 14625765,
 "ebook_access": "borrowable",
 "edition_count": 251,
 "first_publish_year": 1954,
 "has_fulltext": true,
 "ia": [
 "lordofrings00tolk_5",
 "yzklerinefendisi0000jrrt",
 "hobbitguildpubli0000jrrt",
 "lordofrings0000tolk_k7n1",
 "lordofrings0000jrrt",
 "lordofrings0000tolk_o3c6",
 "lordofrings0000tolk_n6w1",
 "osenordosaneis0000tolk",
 "lordofrings0000tolk_d5h0",
 "lordofrings00tolk_2",
 "isbn_9780618343997",
 "snj.lordofrings0000jrrt_y7c7",
 "lordofringstrilo00jrrt",
 "derherrderringed0000jrrt",
 "lordofrings0000tolk_b2r2",
 "lordofringsfello0000jrrt",
 "isbn_9027456836",
 "lordofringsbcaed0000jrrt",
 "lordofrings0000tolk_y0v8",
 "lordofrings00tolk_3",
 "isbn_9780618640157",
 "lordofrings00tolk_1",
 "lordofringsonevo00jrrt",
 "lordofrings00tolk_0"
 ],
 "ia_collection_s": "JaiGyan;ServantsOfKnowledge-Print;americana;bannedbooks;barryuniversity-ol;binghamton-ol;bostonpubliclibrary;bplhoughton;bpljordan-ol;cnusd-ol;cua-ol;delawarecountydistrictlibrary;inlibrary;internetarchivebooks;printdisabled;riceuniversity-ol;rochester-ol;the-claremont-colleges-ol;uiucdisabilityresources;unb-ol;uni-ol",
 "key": "/works/OL27448W",
 "language": [
 "por",
 "tur",
 "rus",
 "bul",
 "jpn",
 "pol",
 "kor",
 "ger",
 "fre",
 "eng",
 "ita",
 "glg",
 "cze",
 "spa",
 "swe",
 "slo",
 "cat",
 "dut"
 ],
 "lending_edition_s": "OL51711484M",
 "lending_identifier_s": "lordofrings00tolk_5",
 "public_scan_b": false,
 "title": "The Lord of the Rings"
 }]}
 */

import Foundation
import SwiftUI

// MARK: - BookStatus
enum BookStatus: String, Codable, CaseIterable {
    case wantToRead = "Want To Read"
    case reading = "Reading"
    case read = "Read"
    case none = "Add To List"
    
    func icon() -> String {
        switch self {
        case .none: return "questionmark.circle"
        case .reading: return "book.fill"
        case .read: return "checkmark.circle.fill"
        case .wantToRead: return "bookmark.fill"
        }
    }
    
    func color() -> Color {
        switch self {
        case .none: return .gray
        case .reading: return .blue
        case .read: return .green
        case .wantToRead: return .yellow
        }
    }
}

// MARK: - Book
struct Book: Identifiable, Codable {
    let id: String
    let title: String?
    let author: String?
    let coverImageURL: URL?
    let status: BookStatus?
    
    init(id: String, title: String?, author: String?, coverImageURL: URL?, status: BookStatus = .none) {
        self.id = id
        self.title = title
        self.author = author
        self.coverImageURL = coverImageURL
        self.status = status
    }
    
    func with(status newStatus: BookStatus) -> Book {
        Book(id: id,
             title: title,
             author: author,
             coverImageURL: coverImageURL,
             status: newStatus)
    }
}


// MARK: - test examples
extension Book {
    static let bookExample: Book = Book(id: "123456", title: "Harry Potter", author: "J K Rowling", coverImageURL: URL(string: "https://covers.openlibrary.org/b/id/14627060-L.jpg"))
    
    static let booksExample: [Book] = Array(repeating: bookExample, count: 10)
}

extension Book {
    /// Firestore-safe ID (no “/”)
    var docID: String {
        id.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
            .replacingOccurrences(of: "/", with: "_")
    }
}


