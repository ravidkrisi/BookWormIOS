//
//  HomeView.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 22/06/2025.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    // services
    let booksService: BooksRemoteRepo
    
    init(booksService: BooksRemoteRepo) {
        self.booksService = booksService
        Task {
            await getBooks()
        }
    }
    
    @Published var trendingTodayBooks: [Book]? = nil
    @Published var trendingWeeklyBooks: [Book]? = nil
    @Published var trendingMonthlyBooks: [Book]? = nil
    
    var cancellables: Set<AnyCancellable> = []
    
    func getBooks() async {
        // set publishers
        let trendingTodayBooksPublisher = booksService.fetchBooksByList("today")
        let trendingWeeklyBooksPublisher = booksService.fetchBooksByList("weekly")
        let trendingMonthlyBooksPublisher = booksService.fetchBooksByList("weekly")
        
        // bind publishers
        bind(trendingTodayBooksPublisher, to: \.trendingTodayBooks, storeIn: &cancellables)
        bind(trendingWeeklyBooksPublisher, to: \.trendingWeeklyBooks, storeIn: &cancellables)
        bind(trendingMonthlyBooksPublisher, to: \.trendingMonthlyBooks, storeIn: &cancellables)
    }
}

struct HomeView: View {
    @ObservedObject var vm: HomeViewModel
    @EnvironmentObject var container: DIContainer

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.vertical, showsIndicators: false) {
                BooksSection(title: "Featured Today", placeholder: "no books found", books: vm.trendingTodayBooks)
                
                Divider()
                
                BooksSection(title: "Trending Weekly", placeholder: "no books found", books: vm.trendingWeeklyBooks)
                
                Divider()
                
                BooksSection(title: "Hot This Month", placeholder: "no books found", books: vm.trendingMonthlyBooks?.shuffled())
                
                
                Spacer()
            }
            
        }
        .padding()
        
    }
}

struct BooksSection: View {
    let title: String
    let placeholder: String
    let books: [Book]?
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            VStack {
                if let books = books {
                    if books.isEmpty {
                        Text(placeholder)
                    } else {
                        BooksScrollView(books: books)
                    }
                } else {
                    ProgressView()
                }
            }
            .frame(maxWidth: .infinity, minHeight: 170)
        }
    }
}




#Preview {
    let container = DIContainer.test()
    
    NavigationStack {
        HomeView(vm: container.homeViewModel)
            .environmentObject(container)
    }
}
