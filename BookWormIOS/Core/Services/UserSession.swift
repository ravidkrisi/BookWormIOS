//
//  UserSession.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 14/06/2025.
//

import Foundation
import SwiftUI



@MainActor
final class UserSession: ObservableObject {
    @Published var user: UserModel?
    
    init(_ user: UserModel? = nil) {
        // Initialize with nil user
        self.user = user
    }
    
    func setUser(_ user: UserModel) {
        self.user = user
    }
    
    func clearUser() {
        self.user = nil
    }
}

extension UserSession {
    static let test = UserSession(UserModel.example)
}
