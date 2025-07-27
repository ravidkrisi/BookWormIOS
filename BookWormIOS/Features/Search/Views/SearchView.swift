//
//  SearchView.swift
//  BookWormIOS
//
//  Created by Ravid Krisi on 23/06/2025.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var books: [Book] = []
    
    // services
    let booksService: BooksRemoteRepo
    
    init(booksService: BooksRemoteRepo) {
        self.booksService = booksService
        bindSearch()
    }
    
    
    private func bindSearch() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .flatMap { [weak self] query -> AnyPublisher<[Book], Never> in
                guard let self = self, !query.isEmpty,
                      let publisher = self.booksService.fetchBooksByQuery(query) else {
                    return Just([]).eraseToAnyPublisher()
                }
                return publisher
                    .replaceError(with: []) // catch errors and return empty list
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$books)
    }
    
    func clearTextField() {
        searchText = ""
    }
}

struct SearchView: View {
    
    @ObservedObject var vm: SearchViewModel
    @EnvironmentObject var container: DIContainer
    
    var showClearBtn: Bool {
        vm.searchText.isEmpty ? false : true
    }
    
    var body: some View {
        VStack {
            searchTextField
                .padding(.bottom, 5)
            
            // books list
            BooksList(books: vm.books)
        }
        .padding()
    }
}

extension SearchView {
    var searchTextField: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                    .font(.caption)
                
                TextField("Title, author", text: $vm.searchText)
                    .overlay(
                        Group {
                            if showClearBtn {
                                Button(action: {
                                    vm.clearTextField()
                                }, label: {
                                    Image(systemName: "xmark.circle")
                                        .foregroundStyle(.secondary.opacity(0.5))
                                        .font(.headline)
                                })
                            }
                        },
                        alignment: .trailing
                    )
                
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                
            )
        }
    }
}

#Preview {
    let container = DIContainer.test()
    
    NavigationStack {
        SearchView(vm: container.searchViewModel)
            .environmentObject(container)
    }
}
