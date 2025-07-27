//
//  BookWormIOSApp.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 09/06/2025.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct BookWormIOSApp: App {
    
    let container: DIContainer
    // configure firebase
    init() {
        FirebaseApp.configure()
        self.container = DIContainer.prod()
    }
    
    var body: some Scene {
        
        WindowGroup {
            NavigationStack {
                AuthRootView(vm: container.authViewModel)
            }
            .environmentObject(container)
        }
    }
}
