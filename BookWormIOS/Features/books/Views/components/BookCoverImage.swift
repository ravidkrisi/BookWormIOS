//
//  BookCoverImage.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 24/06/2025.
//

import SwiftUI

struct BookCoverImage: View {
    let url: URL?
    let coverWidth: CGFloat
    var coverHeight: CGFloat {
        coverWidth * 1.6
    }
    
    init(url: URL?, coverWidth: CGFloat = 100) {
        self.url = url
        self.coverWidth = coverWidth
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.1))
            
            if let url = url {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .failure:
                        placeholder
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .clipped()
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                placeholder
            }
        }
        .frame(width: coverWidth, height: coverHeight)
        .cornerRadius(8)
        .clipped()
        
    }
}

extension BookCoverImage {
    var placeholder: some View {
        Image(systemName: "book.fill")
            .resizable()
            .scaledToFit()
            .foregroundColor(.gray)
            .padding(20)
    }
}
#Preview {
    BookCoverImage(url: Book.bookExample.coverImageURL)
}
