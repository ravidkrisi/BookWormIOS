//
//  ListResponse.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 24/06/2025.
//

import Foundation

// MARK: API RESPONSE EXAMPLE
/*
{
  "key": "/subjects/bestsellers",
  "name": "bestsellers",
  "subject_type": "subject",
  "work_count": 7,
  "works": [
    {
      "key": "/works/OL1497303W",
      "title": "Guide to best plays",
      "edition_count": 5,
      "cover_id": 4416447,
      "cover_edition_key": "OL4549705M",
      "subject": [
        "Drama",
        "Indexes",
        "Bibliography",
        "Stories, plots",
        "Bibliographie",
        "Index",
        "Histoires, intrigues",
        "Bestsellers",
        "Théâtre (Genre littéraire)",
        "Toneelstukken",
        "Konkordanz",
        "Geschichte",
        "Theatre (Genre litteraire)",
        "Drama, bibliography",
        "Drama, dictionaries, indexes, etc.",
        "Drama, stories, plots, etc."
      ],
      "ia_collection": [
        "barryuniversity-ol",
        "binghamton-ol",
        "dartmouthlibrary-ol",
        "denverpubliclibrary-ol",
        "drakeuniversity-ol",
        "framingham-ol",
        "gwulibraries-ol",
        "inlibrary",
        "internetarchivebooks",
        "ithacacollege-ol",
        "occidentalcollegelibrary-ol",
        "printdisabled",
        "randolph-macon-college-ol",
        "riceuniversity-ol",
        "rochester-ol",
        "the-claremont-colleges-ol",
        "uni-ol",
        "universityofarizona-ol",
        "universityofcoloradoboulder-ol",
        "universityofoklahoma-ol",
        "wrlc-ol"
      ],
      "printdisabled": true,
      "lending_edition": "OL2372387M",
      "lending_identifier": "drurysguidetobes00drur",
      "authors": [
        {
          "key": "/authors/OL159647A",
          "name": "Francis K. W. Drury"
        }
      ],
      "first_publish_year": 1953,
      "ia": "drurysguidetobes00drur",
      "public_scan": false,
      "has_fulltext": true,
      "availability": {
        "status": "borrow_available",
        "available_to_browse": true,
        "available_to_borrow": true,
        "available_to_waitlist": false,
        "is_printdisabled": true,
        "is_readable": false,
        "is_lendable": true,
        "is_previewable": true,
        "identifier": "drurysguidetobes00drur",
        "isbn": "0810819805",
        "oclc": null,
        "openlibrary_work": "OL1497303W",
        "openlibrary_edition": "OL2372387M",
        "last_loan_date": "2018-07-04T02:20:35Z",
        "num_waitlist": "0",
        "last_waitlist_date": null,
        "is_restricted": true,
        "is_browseable": true,
        "__src__": "core.models.lending.get_availability"
      }
    },
    {
      "key": "/works/OL1990417W",
      "title": "Making the list",
      "edition_count": 2,
      "cover_id": 507296,
      "cover_edition_key": "OL3951699M",
      "subject": [
        "Books and reading",
        "Best sellers",
        "Bibliography",
        "Popular literature",
        "History and criticism",
        "History",
        "Letterkunde",
        "Bestsellers",
        "New York Times reviewed",
        "Best sellers, bibliography",
        "Books and reading, history",
        "Popular literature, history and criticism"
      ],
      "ia_collection": [
        "cua-ol",
        "dartmouthlibrary-ol",
        "denverpubliclibrary-ol",
        "drakeuniversity-ol",
        "gwulibraries-ol",
        "inlibrary",
        "internetarchivebooks",
        "johnshopkins-ol",
        "printdisabled",
        "randolph-macon-college-ol",
        "riceuniversity-ol",
        "rochester-ol",
        "the-claremont-colleges-ol",
        "udc-ol",
        "uni-ol",
        "universityofcoloradoboulder-ol",
        "universityofoklahoma-ol"
      ],
      "printdisabled": true,
      "lending_edition": "OL3951699M",
      "lending_identifier": "makinglistcultur0000kord",
      "authors": [
        {
          "key": "/authors/OL239594A",
          "name": "Michael Korda"
        }
      ],
      "first_publish_year": 2001,
      "ia": "makinglistcultur0000kord",
      "public_scan": false,
      "has_fulltext": true,
      "availability": {
        "status": "borrow_available",
        "available_to_browse": true,
        "available_to_borrow": true,
        "available_to_waitlist": false,
        "is_printdisabled": true,
        "is_readable": false,
        "is_lendable": true,
        "is_previewable": true,
        "identifier": "makinglistcultur0000kord",
        "isbn": "9780760725597",
        "oclc": null,
        "openlibrary_work": "OL1990417W",
        "openlibrary_edition": "OL3951699M",
        "last_loan_date": "2020-06-25T23:02:05Z",
        "num_waitlist": "0",
        "last_waitlist_date": "2019-08-16T12:36:58Z",
        "is_restricted": true,
        "is_browseable": true,
        "__src__": "core.models.lending.get_availability"
      }
    },
    {
      "key": "/works/OL5667624W",
      "title": "A world made safe",
      "edition_count": 1,
      "cover_id": 4240858,
      "cover_edition_key": "OL3262904M",
      "subject": [
        "American fiction",
        "Best sellers",
        "Bibliography",
        "Books and reading",
        "History",
        "History and criticism",
        "Popular literature",
        "Social values in literature",
        "Best-sellers",
        "Wert",
        "Ethik",
        "Bestseller",
        "Dans la litterature",
        "Amerikaans",
        "Bestsellers",
        "Valeurs (philosophie)",
        "University of South Alabama",
        "Histoire et critique",
        "Themes, motifs",
        "Roman americain",
        "Roman américain",
        "Dans la littérature",
        "Thèmes, motifs",
        "Values in literature"
      ],
      "ia_collection": [
        "binghamton-ol",
        "gwulibraries-ol",
        "inlibrary",
        "internetarchivebooks",
        "johnshopkins-ol",
        "printdisabled",
        "rochester-ol",
        "unb-ol",
        "uni-ol",
        "universityofarizona-ol",
        "universityofoklahoma-ol"
      ],
      "printdisabled": true,
      "lending_edition": "OL3262904M",
      "lending_identifier": "worldmadesafeval0000lofr",
      "authors": [
        {
          "key": "/authors/OL1378500A",
          "name": "Erik Löfroth"
        }
      ],
      "first_publish_year": 1983,
      "ia": "worldmadesafeval0000lofr",
      "public_scan": false,
      "has_fulltext": true,
      "availability": {
        "status": "borrow_available",
        "available_to_browse": true,
        "available_to_borrow": true,
        "available_to_waitlist": false,
        "is_printdisabled": true,
        "is_readable": false,
        "is_lendable": true,
        "is_previewable": true,
        "identifier": "worldmadesafeval0000lofr",
        "isbn": "9155413943",
        "oclc": null,
        "openlibrary_work": "OL5667624W",
        "openlibrary_edition": "OL3262904M",
        "last_loan_date": "2020-03-10T11:38:55Z",
        "num_waitlist": "0",
        "last_waitlist_date": null,
        "is_restricted": true,
        "is_browseable": true,
        "__src__": "core.models.lending.get_availability"
      }
    },
    {
      "key": "/works/OL13302987W",
      "title": "Schreiben für den Markt",
      "edition_count": 1,
      "cover_id": null,
      "cover_edition_key": null,
      "subject": [
        "Criticism and interpretation",
        "Literature and society",
        "Bestsellers"
      ],
      "ia_collection": [
        ""
      ],
      "printdisabled": false,
      "lending_edition": "",
      "lending_identifier": "",
      "authors": [
        {
          "key": "/authors/OL6202274A",
          "name": "Gero Arnscheidt"
        }
      ],
      "first_publish_year": 2005,
      "ia": null,
      "public_scan": false,
      "has_fulltext": false
    },
    {
      "key": "/works/OL12638836W",
      "title": "Signorsı̀",
      "edition_count": 1,
      "cover_id": 8539499,
      "cover_edition_key": null,
      "subject": [
        "Fiction",
        "Italian Fiction",
        "bestsellers",
        "novella"
      ],
      "ia_collection": [
        ""
      ],
      "printdisabled": false,
      "lending_edition": "",
      "lending_identifier": "",
      "authors": [
        {
          "key": "/authors/OL5636019A",
          "name": "Liala"
        }
      ],
      "first_publish_year": 2001,
      "ia": null,
      "public_scan": false,
      "has_fulltext": false
    },
    {
      "key": "/works/OL4778868W",
      "title": "The myth of superwoman",
      "edition_count": 1,
      "cover_id": 4084780,
      "cover_edition_key": "OL2191446M",
      "subject": [
        "American fiction",
        "Best sellers",
        "Bibliography",
        "Books and reading",
        "French fiction",
        "History and criticism",
        "Literature publishing",
        "Myth in literature",
        "Popular literature",
        "Women",
        "Women in literature",
        "American fiction, history and criticism",
        "Mythology in literature",
        "Best-sellers",
        "Bibliographie",
        "Paralittérature",
        "Histoire et critique",
        "Roman américain",
        "Roman français",
        "Littérature",
        "Édition",
        "Femmes dans la littérature",
        "Mythe dans la littérature",
        "LITERARY CRITICISM",
        "Women Authors",
        "General",
        "Bestsellers",
        "Vrouwelijke auteurs",
        "Triviale literatuur",
        "Vrouwen",
        "History",
        "Fiction",
        "Publishing"
      ],
      "ia_collection": [
        "binghamton-ol",
        "dartmouthlibrary-ol",
        "drakeuniversity-ol",
        "gwulibraries-ol",
        "internetarchivebooks",
        "johnshopkins-ol",
        "printdisabled",
        "rochester-ol",
        "the-claremont-colleges-ol",
        "universityofarizona-ol",
        "universityofcoloradoboulder-ol",
        "wrlc-ol"
      ],
      "printdisabled": true,
      "lending_edition": "",
      "lending_identifier": "",
      "authors": [
        {
          "key": "/authors/OL1004041A",
          "name": "Resa L. Dudovitz"
        }
      ],
      "first_publish_year": 1990,
      "ia": "mythofsuperwoman0000dudo",
      "public_scan": false,
      "has_fulltext": true,
      "availability": {
        "status": "private",
        "available_to_browse": false,
        "available_to_borrow": false,
        "available_to_waitlist": false,
        "is_printdisabled": true,
        "is_readable": false,
        "is_lendable": false,
        "is_previewable": true,
        "identifier": "mythofsuperwoman0000dudo",
        "isbn": "0415031869",
        "oclc": null,
        "openlibrary_work": "OL4778868W",
        "openlibrary_edition": "OL2191446M",
        "last_loan_date": null,
        "num_waitlist": null,
        "last_waitlist_date": null,
        "is_restricted": true,
        "is_browseable": false,
        "__src__": "core.models.lending.get_availability"
      }
    },
    {
      "key": "/works/OL19096978W",
      "title": "Antisemitische Geschichtsbilder",
      "edition_count": 1,
      "cover_id": 8415635,
      "cover_edition_key": "OL26766326M",
      "subject": [
        "Antisemitism",
        "Congresses",
        "History",
        "Aufsatzsammlung",
        "Geschichtsbild",
        "Antisemitismus",
        "Joden",
        "Representatie (algemeen)",
        "Antisemitisme",
        "Geschiedverhalen",
        
        "Bestsellers"
      ],
      "ia_collection": [
        ""
      ],
      "printdisabled": false,
      "lending_edition": "",
      "lending_identifier": "",
      "authors": [
        {
          "key": "/authors/OL469088A",
          "name": "Werner Bergmann"
        }
      ],
      "first_publish_year": 2009,
      "ia": null,
      "public_scan": false,
      "has_fulltext": false
    }
  ]
}
 */

struct ListResponse: Codable {
    let works: [ListBook]?
}

struct ListBook: Codable, ToBook {
    let title: String?
    let key: String?
    let authorName: [String]?
    let coverI: Int?

    enum CodingKeys: String, CodingKey {
        case title
        case key
        case authorName = "author_name"
        case coverI = "cover_i"
    }

    func toBook(coverImageURL: URL?) -> Book {
        Book(
            id: key ?? UUID().uuidString,
            title: title ?? "",
            author: authorName?.first ?? "Unknown Author",
            coverImageURL: coverImageURL
        )
    }
}
