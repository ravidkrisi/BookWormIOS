//
//  BooksSearchList.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 23/06/2025.
//

import SwiftUI

struct BooksList: View {
    let books: [Book]
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 4) {
                ForEach(books) { book in
                    NavigationLink {
                        BookInfoView(book: book)
                    } label: {
                        BookTile(book: book)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BooksList(books: Book.booksExample)
    }
}
