//
//  FBAuthApp.swift
//  FBAuth
//
//  Created by Reyab Saluja on 2023-09-30.
//

import SwiftUI
import Firebase

@main
struct FBAuthApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
