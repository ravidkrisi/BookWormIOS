//
//  ProfileView.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 27/06/2025.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var books: [Book] = []
    
    @Published var WantToReadBooks: [Book]? = nil
    @Published var readBooks: [Book]? = nil
    @Published var readingBooks: [Book]? = nil
    
    @Published var isLoading: Bool = true
    
    // services
    let userSession: UserSession
    let booksRepo: BooksLocalRepo
    
    init(userSession: UserSession, booksRepo: BooksLocalRepo) {
        self.userSession = userSession
        self.booksRepo = booksRepo
    }
    
    @MainActor
    func loadBooks() {
        Task {
            isLoading = true
            guard let uid = userSession.user?.id else { return }
            books = try await booksRepo.getAllUserBooks(uid: uid)
            WantToReadBooks = books.filter { $0.status == .wantToRead }
            readBooks = books.filter { $0.status == .read }
            readingBooks = books.filter { $0.status == .reading }
            isLoading = false
            print("loaded books")
        }
    }
    
}

struct MyBooksView: View {
    
    @ObservedObject var vm: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.vertical, showsIndicators: false) {
                
                statsSection
                    .padding(.vertical)
                
                Divider()
                
                // want to read section
                BooksSection(title: "Want To Read", placeholder: "Add Books", books: vm.WantToReadBooks)
                
                Divider()
                
                // previously Read section
                Text("Previously Read")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if let readBooks = vm.readBooks {
                    BooksList(books: readBooks)
                } else {
                    Text("No Books Read Yet")
                }
                
                
                Spacer()
            }
            
        }
        .padding()
        .task {
            vm.loadBooks()
        }
    }
}

extension MyBooksView {
    var statsSection: some View {
        HStack(spacing: 16) {
            statTile(title: "Reading Now", value: vm.readingBooks?.count, color: BookStatus.reading.color())
            statTile(title: "Want To Read", value: vm.WantToReadBooks?.count, color: BookStatus.wantToRead.color())
            statTile(title: "Previously Read", value: vm.readBooks?.count, color: BookStatus.read.color())
        }
    }
}


struct statTile: View {
    let title: String
    let value: Int?
    let color: Color
    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .padding(.bottom, 2)
            
            Text("\(value ?? 0)")
                .font(.largeTitle)
        }
        .frame(width: 100, height: 100)
        .background(color.opacity(0.2))
        .cornerRadius(12)
    }
}


#Preview {
    let container = DIContainer.test()
    
    NavigationStack {
        MyBooksView(vm: container.profileViewModel)
    }
}
