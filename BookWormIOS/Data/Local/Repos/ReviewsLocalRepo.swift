//
//  ReviewsLocalRepo.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 01/07/2025.
//

import Foundation
import FirebaseFirestore

protocol ReviewsLocalRepo {
    func addReview(_ review: Review) async throws
    func getAllBookReviews(_ bookId: String) async throws -> [Review]
}

class FirestoreReviewsService : ReviewsLocalRepo {
   
    
    
    private let db = Firestore.firestore()
    let reviewsCollection = "reviews"
    
    func getAllBookReviews(_ bookId: String) async throws -> [Review] {
            // Build the query
            let snapshot = try await db.collection("reviews")
                .whereField("bookId", isEqualTo: bookId)
                .getDocuments()

            // Convert each document into `Review`
            return try snapshot.documents.map { doc in
                try doc.data(as: Review.self)
            }
        }
    
    func addReview(_ review: Review) async throws {
        do {
            try db.collection(reviewsCollection).document(review.id).setData(from: review)
            print("review added")
        } catch {
           print("failed to add review")
        }
    }
}
