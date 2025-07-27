//
//  BookSearchTile.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 23/06/2025.
//

import SwiftUI

struct BookTile: View {
    let book: Book
    var body: some View {
        HStack(alignment: .center) {
            // cover image
            BookCoverImage(url: book.coverImageURL, coverWidth: 55)
            
            VStack (alignment: .leading){
                // book title
                Text(book.title ?? "")
                    .font(.headline)
                // book author
                Text(book.author ?? "")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding()
            
            Spacer()
            
            // navigation chevron
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    BookTile(book: .bookExample)
}
