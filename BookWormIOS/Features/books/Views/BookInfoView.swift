import SwiftUI

// MARK: - Main View

struct BookInfoView: View {
    
    let book: Book
    
    @State private var reviews: [Review] = []
    @State private var selectedStatus: BookStatus = .none
    @State private var isLoadingStatus = true
    @State private var isLoadingReviews = true
    @State private var showReviewForm = false
    
    @EnvironmentObject var container: DIContainer
    
    // Average rating computed from reviews
    private var rating: Double {
        guard !reviews.isEmpty else { return 0.0 }
        let total = reviews.map { $0.rating }.reduce(0, +)
        return Double(total) / Double(reviews.count)
    }
    
    // Show "Add Review" button only if user read the book and hasn't reviewed yet
    private var showAddReview: Bool {
        guard let currentUserId = container.userSessionService.user?.id else { return false }
        return selectedStatus == .read && !reviews.contains(where: { $0.uid == currentUserId })
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                
                // Book Cover
                BookCoverImage(url: book.coverImageURL, coverWidth: 170)
                    .padding(.top, 50)
                
                // Rating
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", rating))
                        .font(.subheadline)
                }
                
                // Title and Author
                Text(book.title ?? "Untitled")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text(book.author ?? "Unknown")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                // Book Status Section
//                Group {
//                    if isLoadingStatus {
//                        ProgressView()
//                    } else {
//                        if selectedStatus == .none {
//                            // Picker to add status
//                            Picker("Add to list", selection: $selectedStatus) {
//                                ForEach(BookStatus.allCases.filter { $0 != .none }, id: \.self) { status in
//                                    Text(status.rawValue.capitalized).tag(status)
//                                }
//                            }
//                            .pickerStyle(.segmented)
//                            .padding(.horizontal, 20)
////                            .padding(.vertical, 10)
////                            .background(Color.gray.opacity(0.9))
////                            .clipShape(Capsule())
//                            .onChange(of: selectedStatus) { _ in
//                                updateBookStatus()
//                            }
//                        } else {
//                            // Show selected status pill with clear button
//                            HStack(spacing: 10) {
//                                Label {
//                                    Text(selectedStatus.rawValue.capitalized)
//                                } icon: {
//                                    Image(systemName: selectedStatus.icon())
//                                }
//                                .padding(.horizontal, 16)
//                                .padding(.vertical, 8)
//                                .background(selectedStatus.color().opacity(0.2))
//                                .clipShape(Capsule())
//                                
//                                Button {
//                                    withAnimation {
//                                        selectedStatus = .none
//                                        updateBookStatus()
//                                    }
//                                } label: {
//                                    Image(systemName: "xmark.circle.fill")
//                                        .foregroundColor(.secondary)
//                                }
//                            }
//                        }
//                    }
//                }
//                .padding(.vertical, 10)
                
                Group {
                    if isLoadingStatus {
                        ProgressView()
                    } else {
                        if selectedStatus == .none {
                            Picker("Add to list", selection: $selectedStatus) {
                                ForEach(BookStatus.allCases.filter { $0 != .none }, id: \.self) { status in
                                    Text(status.rawValue.capitalized).tag(status)
                                }
                            }
                            .pickerStyle(.segmented)
                            .padding(.horizontal, 20)
                        } else {
                            HStack(spacing: 10) {
                                Label {
                                    Text(selectedStatus.rawValue.capitalized)
                                } icon: {
                                    Image(systemName: selectedStatus.icon())
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(selectedStatus.color().opacity(0.2))
                                .clipShape(Capsule())

                                Button {
                                    withAnimation {
                                        updateBookStatus()
                                        selectedStatus = .none
                                    }
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
                .onChange(of: selectedStatus) { newValue in
                    // 👇 Prevent firing when user clears the status
                    if newValue != .none {
                        updateBookStatus()
                    }
                }
                .padding(.vertical, 10)

                
                // Add Review Button
                if showAddReview {
                    Button(action: {
                        showReviewForm = true
                    }) {
                        Text("Add Review")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                
                Divider()
                    .padding(.vertical, 10)
                
                // Reviews Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Reviews")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    if isLoadingReviews {
                        ProgressView()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                    } else {
                        if reviews.isEmpty {
                            Text("No reviews yet")
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                        } else {
                            ForEach(reviews) { review in
                                ReviewTile(review: review)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer(minLength: 30)
            }
            .frame(maxWidth: .infinity)
        }
        .sheet(isPresented: $showReviewForm) {
            NavigationStack {
                AddReviewView(
                    vm: container.addReviewViewModel,
                    userID: container.userSessionService.user!.id,
                    bookID: book.docID,
                    userName: container.userSessionService.user!.name
                )
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            showReviewForm = false
                        }
                    }
                }
            }
        }
        .task {
            await loadInitialStatus()
            await loadReviews()
        }
    }
    
    // MARK: - Async Data Loading
    
    private func loadReviews() async {
        isLoadingReviews = true
        do {
            reviews = try await container.reviewsLocalRepo.getAllBookReviews(book.docID)
        } catch {
            // handle error, e.g. show alert or log
            reviews = []
        }
        isLoadingReviews = false
    }
    
    private func loadInitialStatus() async {
        isLoadingStatus = true
        guard let uid = container.userSessionService.user?.id else {
            isLoadingStatus = false
            return
        }
        do {
            if let userBook = try await container.booksLocalService.getUsersBook(uid: uid, bookId: book.id) {
                selectedStatus = userBook.status ?? .none
            } else {
                selectedStatus = .none
            }
        } catch {
            selectedStatus = .none
        }
        isLoadingStatus = false
    }
    
    private func updateBookStatus() {
        guard let uid = container.userSessionService.user?.id else { return }
        Task {
            do {
                try await container.booksLocalService.updateBookStatus(uid: uid, book: book, status: selectedStatus)
            } catch {
                // Handle error (optional)
            }
        }
    }
}

// MARK: - Supporting Views

struct StatusPill: View {
    let status: BookStatus
    let onTap: () -> Void

    var body: some View {
        Text(status.rawValue.capitalized)
            .font(.caption)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.gray.opacity(0.2))
            .clipShape(Capsule())
            .onTapGesture {
                onTap()
            }
    }
}

// MARK: - Preview

#Preview {
    let container = DIContainer.test()
    
    NavigationStack {
        BookInfoView(book: .bookExample)
            .environmentObject(container)
    }
}
