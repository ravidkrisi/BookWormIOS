//
//  FirebaseAuthService.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 09/06/2025.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

protocol AuthServiceProtocol {
    
    func signInWithGoogle() async throws -> UserModel
    func signOut() async throws
    func currentUser() throws -> UserModel?
    
}
final class FirebaseAuthService: AuthServiceProtocol {
    
    private let _auth = Auth.auth()
    
    private func signInWithCredential(_ credential: AuthCredential) async throws -> UserModel {
        let authDataResult = try await _auth.signIn(with: credential)
        let userModel = UserModel(user: authDataResult.user)
        
        return userModel
    }
    
    func signOut() async throws {
        try _auth.signOut()
    }
    
    func currentUser() -> UserModel? {
        guard let user = _auth.currentUser else {
            return nil
        }
        
        return UserModel(user: user)
    }
    
    // MARK: SIGN IN GOOGLE
    func signInWithGoogle() async throws -> UserModel {
        guard let topVC = await TopView.shared.topViewController() else {
            throw URLError(.badURL)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badURL)
        }
        let accessToken = gidSignInResult.user.accessToken.tokenString
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        let userModel = try await signInWithCredential(credential)
        
        return userModel
    }}
