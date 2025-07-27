//
//  RootView.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 10/06/2025.
//

import SwiftUI

struct AuthRootView: View {
    
    @EnvironmentObject var container: DIContainer
    @ObservedObject var vm: AuthViewModel
    
    
    var body: some View {
        ZStack {
            if vm.isLoading {
                ProgressView()
            } else {
                VStack {
                    
                    // Authenticated
                    if vm.isAuthenticated {
                        
                        // first time user
                        if vm.isFirstTime {
                            FirstTimeUserView(vm: container.firstTimeUserViewModel, isFirstTimeUser: $vm.isFirstTime)
                        }
                        
                        // existing user
                        else {
                            MainTabView(vm: container.mainTabViewModel)
                        }
                    } else {
                        AuthView(vm: container.authViewModel)
                    }
                }
            }
        }
        .task {
            // check if authenticated already
            do {
                try await vm.currentUser()
            } catch {
                print("Failed to get current user: \(error)")
            }
        }
    }
}

#Preview {
    let container = DIContainer.test()
    
    AuthRootView(vm: container.authViewModel)
        .environmentObject(container)
}
