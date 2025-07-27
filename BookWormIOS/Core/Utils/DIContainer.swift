//
//  DependencyContainer.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 10/06/2025.
//

import Foundation

@MainActor
final class DIContainer: ObservableObject {
    
    // MARK: SERVICES
    let authService: AuthServiceProtocol
    let usersDBService: UsersLocalRepo
    let userSessionService: UserSession
    let booksRemoteService: BooksRemoteRepo
    let booksLocalService: BooksLocalRepo
    let reviewsLocalRepo: ReviewsLocalRepo
    
    // MARK: VIEWMODELS
    var authViewModel: AuthViewModel
    var firstTimeUserViewModel: FirstTimeUserViewModel
    var homeViewModel: HomeViewModel
    var searchViewModel: SearchViewModel
    var profileViewModel: ProfileViewModel
    var addReviewViewModel: AddReviewViewModel
    var mainTabViewModel: MainTabViewModel
    
    init(authService: AuthServiceProtocol, usersDBService: UsersLocalRepo, userSessionService: UserSession, booksService: BooksRemoteRepo, booksLocalService: BooksLocalRepo, reviewsLocalRepo: ReviewsLocalRepo) {
        // init services
        self.authService = authService
        self.usersDBService = usersDBService
        self.userSessionService = userSessionService
        self.booksRemoteService = booksService
        self.booksLocalService = booksLocalService
        self.reviewsLocalRepo = reviewsLocalRepo
        
        // init viewmodels
        self.authViewModel = AuthViewModel(authService: authService, usersService: usersDBService, userSession: userSessionService)
        self.firstTimeUserViewModel = FirstTimeUserViewModel(userSession: userSessionService, usersdBService: usersDBService)
        self.homeViewModel = HomeViewModel(booksService: booksService)
        self.searchViewModel = SearchViewModel(booksService: booksService)
        self.profileViewModel = ProfileViewModel(userSession: userSessionService, booksRepo: booksLocalService)
        self.addReviewViewModel = AddReviewViewModel(reviewRepo: reviewsLocalRepo)
        self.mainTabViewModel = MainTabViewModel(userSession: userSessionService)
    }
}

extension DIContainer {

    /// Factory for the production graph
    static func prod() -> DIContainer {
        let usersDB      = FirestoreUsersService()
        let auth         = FirebaseAuthService()
        let userSession  = UserSession()
        let booksRemote  = OpenLibraryApiService()
        let booksLocal   = FirestoreBooksService(usersDBservice: usersDB)
        let reviewsLocal = FirestoreReviewsService()

       
        return DIContainer(
            authService: auth,
            usersDBService: usersDB,
            userSessionService: userSession,
            booksService: booksRemote,
            booksLocalService: booksLocal,
            reviewsLocalRepo: reviewsLocal
        )
    }

    /// Factory for mocks / stubs
    static func test() -> DIContainer {
        let usersDB      = FirestoreUsersService()
        let auth         = FirebaseAuthService()
        let userSession = UserSession.test
        let booksRemote = OpenLibraryApiService()
        let booksLocal  = FirestoreBooksService(usersDBservice: usersDB)
        let reviewsLocal = FirestoreReviewsService()

        return DIContainer(
            authService: auth,
            usersDBService: usersDB,
            userSessionService: userSession,
            booksService: booksRemote,
            booksLocalService: booksLocal,
            reviewsLocalRepo: reviewsLocal
        )
    }
}

