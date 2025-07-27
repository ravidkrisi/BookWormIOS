//
//  AddReviewView.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 02/07/2025.
//

import SwiftUI

class AddReviewViewModel: ObservableObject {
    // services
    let reviewRepo: ReviewsLocalRepo
    
    init(reviewRepo: ReviewsLocalRepo) {
        self.reviewRepo = reviewRepo
    }
    
    func addReview(_ review: Review) async throws {
        try await reviewRepo.addReview(review)
    }
}

// MARK: - Star-rating sub-view
struct StarRatingView: View {
    @Binding var rating: Int           // 0–5
    
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundColor(index <= rating ? .yellow : .gray.opacity(0.4))
                    .onTapGesture { rating = index }
                    .accessibilityLabel("\(index) star\(index > 1 ? "s" : "")")
            }
        }
    }
}



struct AddReviewView: View {
    
    @ObservedObject var vm: AddReviewViewModel
    @Environment(\.dismiss) var dismiss
    
    let userID: String
    let bookID: String
    let userName: String
    
    @State private var rating: Int = 0
    @State private var reviewText: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Rating").fontWeight(.bold)) {
                StarRatingView(rating: $rating)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 4)
            }
            
            Section(header: Text("Review (optional)").fontWeight(.bold)) {
                TextField("Write something about this book…", text: $reviewText, axis: .vertical)
                    .lineLimit(4...8)
            }
        }
        .navigationTitle("Add Review")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") { saveReview() }
                    .disabled(rating == 0)
            }
        }    }
    
    private func saveReview() {
        Task {
            do {
                let review = Review(id: UUID().uuidString, bookId: bookID, uid: userID, userName: userName, rating: rating, reviewText: reviewText)
                try await vm.addReview(review)
                await MainActor.run { dismiss() }
            } catch {
                print("failed to add review: \(error)")
            }
        }
    }
}

#Preview {
    let container = DIContainer.test()
    
    NavigationStack {
        AddReviewView(vm: container.addReviewViewModel, userID: "123", bookID: "1234", userName: "ravid")
    }
}
