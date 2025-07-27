//
//  Review.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 01/07/2025.
//

import Foundation

struct Review: Identifiable, Codable {
    let id: String
    let bookId: String
    let uid: String
    let userName: String
    let rating: Int
    let reviewText: String?
}
