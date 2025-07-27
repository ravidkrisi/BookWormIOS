//
//  UserModel.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 10/06/2025.
//

import FirebaseAuth

enum Gender: String, Codable, CaseIterable, Identifiable {
    case male = "Male"
    case female = "Female"
    case other = "Other"
    
    var id: String { self.rawValue }
}

struct UserModel: Codable, Identifiable {
    let id: String
    let name: String
    let email: String
    let photoURL: String?
    let gender: Gender?
    let dateOfBirth: Date?
    
    init(id: String, name: String, email: String, photoURL: String? = nil, gender: Gender? = nil, dateOfBirth: Date? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.photoURL = photoURL
        self.gender = gender
        self.dateOfBirth = dateOfBirth
    }
    
    init(user: User) {
        self.id = user.uid
        self.name = user.displayName ?? ""
        self.email = user.email ?? ""
        self.photoURL = user.photoURL?.absoluteString
        self.gender = nil
        self.dateOfBirth = nil
    }
}

extension UserModel {
    static let example = UserModel(id: "123456", name: "ravid", email: "ravid@gmail.com", photoURL: "112334")
}
