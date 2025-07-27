//
//  BookTileView.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 22/06/2025.
//

import SwiftUI

struct BookScrollItem: View {
    let book: Book
    let coverWidth: CGFloat
    
    init(book: Book, coverWidth: CGFloat = 110) {
        self.book = book
        self.coverWidth = coverWidth
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            BookCoverImage(url: book.coverImageURL, coverWidth: coverWidth)
            
            
            Text(book.title ?? "")
                .font(.headline)
                .lineLimit(1)
            
            Text(book.author ?? "")
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
        .frame(width: coverWidth)
    }
}


#Preview {
    let container = DIContainer.test
    BookScrollItem(book: .bookExample)
}


