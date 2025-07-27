//
//  ReviewTile.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 02/07/2025.
//

import SwiftUI

// MARK: – Static star row (read-only)
struct StarRow: View {
    let rating: Int // 1–5

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .foregroundColor(index <= rating ? .yellow : .gray.opacity(0.4))
            }
        }
    }
}

// MARK: – Full tile
struct ReviewTile: View {
    let review: Review

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Reviewer name + stars
            HStack {
                Text(review.userName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
                StarRow(rating: review.rating)
            }

            // Review text
            if let text = review.reviewText, !text.isEmpty {
                Text(text)
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true) // wrap
            }
        }
        .padding()
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 1)
    }
}

// MARK: – Quick preview
#Preview {
    ReviewTile(
        review: Review(
            id: "1",
            bookId: "xyz",
            uid: "user123",
            userName: "Ravid Krisi",
            rating: 4,
            reviewText: "A compelling story with well-developed characters."
        )
    )
    .padding()
}


