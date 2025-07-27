//
//  AuthView.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 09/06/2025.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift



struct AuthView: View {
    
    @ObservedObject var vm: AuthViewModel
    
    var body: some View {
        VStack {
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                Task {
                    try await vm.SignInGoogle()
                }
            }
        }
    }
}

#Preview {
    let container = DIContainer.test()
    
    AuthView(vm: container.authViewModel)
}
