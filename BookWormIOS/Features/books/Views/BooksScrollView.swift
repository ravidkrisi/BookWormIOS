//
//  BooksScrollView.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 24/06/2025.
//

import SwiftUI

struct BooksScrollView: View {
    
    let books: [Book]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 16) {
                ForEach(books) { book in
                    NavigationLink {
                        BookInfoView(book: book)
                    } label: {
                        BookScrollItem(book: book)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BooksScrollView(books: Book.booksExample)
    }
}
