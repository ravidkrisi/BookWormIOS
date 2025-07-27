//
//  AuthViewModel.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 10/06/2025.
//

import Foundation

@MainActor
final class AuthViewModel: ObservableObject {
    
    @Published var isAuthenticated: Bool = false
    @Published var isFirstTime: Bool = true
    @Published var user: UserModel?
    @Published var isLoading: Bool = true
    
    // services
    private let authService: AuthServiceProtocol
    private let usersService: UsersLocalRepo
    private let userSession: UserSession
    
    init(authService: AuthServiceProtocol, usersService: UsersLocalRepo, userSession: UserSession) {
        self.authService = authService
        self.usersService = usersService
        self.userSession = userSession
        
        self.user = userSession.user
        userSession.$user.receive(on: DispatchQueue.main).assign(to: &$user)
    }
    
    func currentUser() async throws {
        
        // case 1: unauthenticated
        guard let authUser = try authService.currentUser() else {
            isAuthenticated = false
            isFirstTime = true
            userSession.clearUser()
            isLoading = false
            return
        }
        
        isAuthenticated = true
        
        // case 2: authenticated & first time
        guard let user = try await usersService.getUser(id: authUser.id) else {
            // user first time
            isFirstTime = true
            userSession.setUser(authUser)
            isLoading = false
            return
        }
        
        
        
        // case 3: authenticated && existing user
        isFirstTime = false
        userSession.setUser(user)
        isLoading = false
    }
    
    func SignInGoogle() async throws {
        // sign in with google
        _ = try await authService.signInWithGoogle()
        
        // get current user
        try await currentUser()
    }
    
    func signOut() async throws {
        try await authService.signOut()
        isAuthenticated = false
        isFirstTime = true
        userSession.clearUser()
    }
}
