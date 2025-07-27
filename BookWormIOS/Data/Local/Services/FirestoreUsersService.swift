//
//  FirestoreUsersService.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 10/06/2025.
//

import Foundation
import FirebaseFirestore

protocol UsersLocalRepo {
    func getUser(id: String) async throws -> UserModel?
    func addUser(_ user: UserModel) async throws
    func userDocument(id: String) -> DocumentReference
}

class FirestoreUsersService: UsersLocalRepo {
    
    private let db = Firestore.firestore()
    private let _userCollection = "users"
    
    // MARK: - Protocol Implementation
    
    /// get user firestore doc
    /// - Parameter id: user id
    /// - Returns: doc
    func userDocument(id: String) -> DocumentReference {
        db.collection(_userCollection).document(id)
    }
    
    /// get user from users db
    /// - Parameter id: user id
    /// - Returns: user model if user's exist else nil
    func getUser(id: String) async throws -> UserModel? {
        do {
            // query users collection for user's doc
            let querySnapshot = try await db.collection(_userCollection).whereField("id", isEqualTo: id).getDocuments()
            
            guard let doc = querySnapshot.documents.first else {
                // no doc for user
                return nil
            }
            
            // decode doc -> UserModel
            let user = try doc.data(as: UserModel.self)
            
            return user
        }
        catch {
            throw error
        }
    }
    
    /// add user to users db
    /// - Parameter user: user model
    func addUser(_ user: UserModel) async throws {
        do {
            print(user.id)
            try db.collection(_userCollection).document(user.id).setData(from: user)
        } catch {
            print("failed to add user to firestore")
            throw error
        }
    }
}
