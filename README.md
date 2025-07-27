# BookWormIOS

BookWormIOS is a modern iOS app for book lovers to track, discover, and review books. It features user authentication and backend powered by Firebase, and book data fetched from the Open Library API. Built with SwiftUI, Combine, and a clean MVVM architecture, this project is perfect for your portfolio.

---

## 🚀 Features

- **Authentication:** Sign in with Google using Firebase Auth.
- **Book Discovery:** Browse trending books (today, weekly, monthly) and search for any book using Open Library.
- **Book Details:** View detailed info, cover, and author for each book.
- **Personal Library:** Add books to your collection, update their status (e.g., reading, completed).
- **Reviews:** Add and view reviews for books.
- **Profile:** View your profile and tracked books.
- **Modern UI:** Built with SwiftUI, Combine, and a modular MVVM architecture.

---

## 🛠 Tech Stack

- **SwiftUI** for UI
- **Combine** for reactive programming
- **Firebase Auth & Firestore** for authentication and backend
- **Open Library API** for book data
- **Google Sign-In** for easy login
- **MVVM** architecture with dependency injection

---

## 📁 Project Structure

```
BookWormIOS/
  ├── BookWormIOS/                # Main app code
  │   ├── Features/               # Feature modules (Auth, Home, Profile, Review, Search, Books)
  │   ├── Core/                   # Core utilities, DI, extensions
  │   ├── Data/                   # Data layer (Remote: OpenLibrary, Local: Firestore)
  │   ├── Assets.xcassets/        # App assets
  │   ├── BookWormIOSApp.swift    # App entry point
  │   └── ...                     # Other supporting files
  └── BookWormIOS.xcodeproj/      # Xcode project files
```

---

## 📝 Setup Instructions

1. **Clone the repository:**
   ```sh
   git clone <your-repo-url>
   cd BookWormIOS
   ```
2. **Install dependencies:**
   - Open the project in Xcode.
   - Make sure you have a valid `GoogleService-Info.plist` for Firebase in the `BookWormIOS/` directory.
3. **Firebase Setup:**
   - Create a Firebase project.
   - Enable Google Sign-In and Firestore.
   - Download and add your `GoogleService-Info.plist` to the project.
4. **Open Library API:**
   - No API key required. The app uses public endpoints for trending and search.
5. **Build and Run:**
   - Select a simulator or device and run the app from Xcode.

---

## 🏗 Architecture

- **MVVM:** Each feature has its own ViewModel and Model.
- **Dependency Injection:** All services and view models are injected via a central `DIContainer`.
- **Combine:** Used for all async data flows and bindings.
- **SwiftUI Previews:** Many views include preview providers for rapid UI development.

---

## 📂 Notable Files

- `BookWormIOSApp.swift`: App entry point, sets up Firebase and DI.
- `Core/Utils/DIContainer.swift`: Dependency injection container.
- `Data/Remote/Services/OpenLibraryApiService.swift`: Handles all Open Library API calls.
- `Data/Local/Services/FirestoreBooksService.swift`: Manages user book data in Firestore.
- `Features/Auth/`: Authentication flows and models.
- `Features/Home/`: Home screen with trending books.
- `Features/Review/`: Book review functionality.

---

## 📸 Screenshots

*Add screenshots of your app here for best portfolio impact!*

---

## 🙏 Credits

- Book data from [Open Library](https://openlibrary.org/developers/api)
- Authentication and backend by [Firebase](https://firebase.google.com/)

---

## 📄 License

MIT License (or your choice) 
