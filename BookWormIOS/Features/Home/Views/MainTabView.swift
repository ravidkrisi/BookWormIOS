//
//  MainTabView.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 22/06/2025.
//

import SwiftUI

@MainActor
class MainTabViewModel: ObservableObject {
    let userSession: UserSession
    @Published var currUser: UserModel?
    
    init(userSession: UserSession, currUser: UserModel? = nil) {
        self.userSession = userSession
        self.currUser = userSession.user
    }
}

struct MainTabView: View {
    
    @EnvironmentObject var container: DIContainer
    @ObservedObject var vm: MainTabViewModel
    
    enum Tab: String {
        case home, search, myBooks
        
        var tabTitle: String {
            switch self {
            case .home: return "Home"
            case .search: return "Search"
            case .myBooks: return "My Books"
            }
        }

        var icon: String {
            switch self {
            case .home: return "house"
            case .search: return "magnifyingglass"
            case .myBooks: return "book"
            }
        }
    }
    
    @State private var selectedTab: Tab = .home
    
    var navigationTitle: String {
        switch selectedTab {
        case .home:
            if let name = vm.currUser?.name.components(separatedBy: " ").first, !name.isEmpty {
                return "Hello, \(name) 👋"
            } else {
                return "Welcome"
            }
        case .search:
            return "Search"
        case .myBooks:
            return "My Books"
        }
    }
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                HomeView(vm: container.homeViewModel)
                    .tabItem {
                        Label(Tab.home.tabTitle, systemImage: Tab.home.icon)
                    }
                    .tag(Tab.home)
                
                SearchView(vm: container.searchViewModel)
                    .tabItem {
                        Label(Tab.search.tabTitle, systemImage: Tab.search.icon)
                    }
                    .tag(Tab.search)
                
                MyBooksView(vm: container.profileViewModel)
                    .tabItem {
                        Label(Tab.myBooks.tabTitle, systemImage: Tab.myBooks.icon)
                    }
                    .tag(Tab.myBooks)
            }
            .navigationTitle(navigationTitle)
//            .onChange(of: selectedTab) { tab in
//                            if tab == .myBooks {
//                                container.profileViewModel.loadBooks()
//                            }
//                        }
        }
    }
}


#Preview {
    let container = DIContainer.test()
    
    NavigationStack {
        MainTabView(vm: container.mainTabViewModel)
            .environmentObject(container)
    }
}
