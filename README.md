# Firebase SwiftUI Authentication

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
![License](https://img.shields.io/badge/License-MIT-blue.svg)

A clean, modern, and robust user authentication template for iOS apps built with SwiftUI and Firebase. This project provides a ready-to-use solution for user registration and login, designed with best practices and a scalable architecture.


<p align="center">
  <img width="345" alt="Screenshot 2023-10-11 at 3 32 54 PM" src="https://github.com/ReyabSaluja/RegisterLoginPageFirebase/assets/114021780/3e1815e5-8460-4017-a85e-cb2c797dfaae">
  <img width="346" alt="Screenshot 2023-10-11 at 3 34 15 PM" src="https://github.com/ReyabSaluja/RegisterLoginPageFirebase/assets/114021780/b0b6754d-ea43-4fe6-809b-43ba0c1607bd">
</p>

---

## ✨ Features

* **Modern SwiftUI Interface:** A beautiful and responsive UI built entirely with SwiftUI, ensuring a great user experience on all modern iOS devices.
* **Secure Firebase Backend:**
    * **Firebase Authentication:** Handles all user sign-up and sign-in logic securely.
    * **Cloud Firestore:** Stores additional user information (like full name) in a scalable, real-time NoSQL database.
* **Clean MVVM Architecture:** Follows the Model-View-ViewModel design pattern, separating UI from business logic for a codebase that is easy to understand, test, and maintain.
* **Real-time Updates:** The UI automatically reacts to changes in authentication state.
* **Comprehensive Error Handling:** Displays clear, user-friendly error messages for common issues like incorrect passwords or network problems.
* **Easy Customization:** The code is well-organized and commented, making it simple to adapt and extend for your own project's needs.

## 🚀 Getting Started

### Prerequisites

* iOS 15.0+
* Xcode 14.0+
* An active [Firebase project](https://console.firebase.google.com/)

### Installation & Setup

1.  **Clone the Repository**
    ```bash
    git clone [https://github.com/your-username/firebase-swiftui-auth.git](https://github.com/your-username/firebase-swiftui-auth.git)
    cd firebase-swiftui-auth
    ```

2.  **Configure Firebase**
    * In the [Firebase Console](https://console.firebase.google.com/), add a new iOS app to your project.
    * Follow the setup instructions to download the `GoogleService-Info.plist` file.
    * Place the `GoogleService-Info.plist` file in the root directory of your Xcode project.
    * Enable **Email/Password** as a sign-in method in the Firebase Authentication section.
    * Enable the **Cloud Firestore** database.

3.  **Install Dependencies**
    * In Xcode, go to **File > Add Packages...**
    * Add the Swift Package for the Firebase iOS SDK:
        ```
        [https://github.com/firebase/firebase-ios-sdk.git](https://github.com/firebase/firebase-ios-sdk.git)
        ```
    * When prompted, select the `FirebaseAuth` and `FirebaseFirestore` libraries.

4.  **Configure the App Entry Point**
    * Open your main app file (e.g., `FirebaseAuthApp.swift`) and configure Firebase. You'll also need to set up the `AuthViewModel` as an environment object.

    ```swift
    import SwiftUI
    import FirebaseCore

    class AppDelegate: NSObject, UIApplicationDelegate {
      func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
      }
    }

    @main
    struct YourAppName: App {
      // register app delegate for Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
      @StateObject var authViewModel = AuthViewModel()

      var body: some Scene {
        WindowGroup {
          ContentView()
            .environmentObject(authViewModel)
        }
      }
    }
    ```

5.  **Build & Run**
    * Build the project in Xcode and run it on a simulator or a physical device.

---

## 🏗️ Architecture (MVVM)

This project uses the **Model-View-ViewModel (MVVM)** design pattern.

* **Model (`User.swift`):** Represents the data structure for a user. It's a simple `struct` that holds user properties.
* **View (`LoginView.swift`, `RegisterView.swift`):** The SwiftUI views are responsible for the UI. They observe the ViewModel for state changes and send user actions (like button taps) to the ViewModel.
* **ViewModel (`AuthViewModel.swift`):** The bridge between the Model and the View. It contains all the business logic for authentication, communicates with Firebase, and exposes the user's authentication state to the views via `@Published` properties. When the state changes, any view observing the ViewModel automatically updates.

---

## 🤝 Contributing

Contributions are welcome! If you find a bug or have a feature request, please open an issue. If you want to contribute code, please fork the repository and submit a pull request.

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

## 📄 License

This project is licensed under the MIT License. See the `LICENSE` file for details.
