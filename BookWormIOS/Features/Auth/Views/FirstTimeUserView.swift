//
//  FirstTimeUserView.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 16/06/2025.
//

import SwiftUI
import Combine

@MainActor
class FirstTimeUserViewModel: ObservableObject {
    
    @Published var user: UserModel? = nil
    // services
    let userSession: UserSession
    let usersDBService: UsersLocalRepo
    private var cancellables = Set<AnyCancellable>()
    
    // text fields controllers
    @Published var name: String = ""
    @Published var dateOfBirth: Date = Date()
    @Published var gender: Gender = .male
    
    init(userSession: UserSession, usersdBService: UsersLocalRepo) {
        // init services
        self.userSession = userSession
        self.usersDBService = usersdBService
        
        // assign user seesion user to user
        userSession.$user.receive(on: DispatchQueue.main).assign(to: &$user)
        
        userSession.$user.receive(on: DispatchQueue.main).sink { [weak self] user in self?.name = user?.name ?? ""
        }
        .store(in: &cancellables)
    }
    
    func addUser() async {
        let user = UserModel(id: user!.id, name: name, email: user!.email, gender: gender, dateOfBirth: dateOfBirth)
        
        do {
            try await usersDBService.addUser(user)
            userSession.setUser(user)
        } catch {
            print("Error adding user: \(error)")
        }
    }
    
}

struct FirstTimeUserView: View {
    
    @ObservedObject var vm: FirstTimeUserViewModel
    
    @Binding var isFirstTimeUser: Bool
    
    let genders = ["Male", "Female", "Other"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            nameTextField
            
            // date of birth
            dateOfBirthField
            
            // gender
            genderField
            Spacer()
        }
        .padding()
        .navigationTitle("Welcome")
    }
}


extension FirstTimeUserView {
    var nameTextField: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person")
                Text("Name")
                    .bold()
            }
            TextField("Name", text: $vm.name)
                .padding()
                .frame(height: 55)
                .cornerRadius(12)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                })
        }
    }
    
    var dateOfBirthField: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "calendar")
                Text("Date Of Birth")
                    .bold()
            }
            DatePicker("Date of Birth", selection: $vm.dateOfBirth, displayedComponents: .date)
                .padding()
                .frame(height: 55)
            //                           .background(Color(.systemGray6))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                )
        }
    }
    
    var genderField: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "figure.stand")
                Text("Gender")
                    .bold()
            }
            Picker("Gender", selection: $vm.gender) {
                ForEach(Gender.allCases) { gender in
                    Text(gender.rawValue).tag(gender)
                }
            }
            .pickerStyle(.segmented)
            
            Button {
                Task {
                    await vm.addUser()
                    isFirstTimeUser = false
                }
            } label: {
                Text("Create Account")
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 55)
                    .background(Color.blue.gradient)
                    .foregroundStyle(Color.white)
                    .font(.headline)
                    .cornerRadius(12)
            }
        }
    }
}

#Preview {
    let container = DIContainer.test()
    
    NavigationStack {
        FirstTimeUserView(vm: container.firstTimeUserViewModel, isFirstTimeUser: .constant(true))
    }
}
