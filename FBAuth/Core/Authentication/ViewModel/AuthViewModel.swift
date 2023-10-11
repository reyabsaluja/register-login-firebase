//
//  AuthViewModel.swift
//  FBAuth
//
//  Created by Reyab Saluja on 2023-10-02.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUser()
        }
    }
    
    @MainActor
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to sign in user with erre \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(uid: result.user.uid, fullname: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        if let user = Auth.auth().currentUser {
            signOut()
            user.delete()
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
    func uploadProfilePicture(image: UIImage, completion: @escaping (_ url: String?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
            completion(nil)
            return
        }
        
        let storageRef = Storage.storage().reference().child("profile_pics/\(UUID().uuidString).jpg")
        
        storageRef.putData(imageData, metadata: nil) { (_, error) in
            if error != nil {
                print("Error uploading image to Firebase Storage.")
                completion(nil)
            } else {
                storageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        completion(nil)
                        return
                    }
                    completion(downloadURL.absoluteString)
                }
            }
        }
    }
    
    func updateProfilePictureURL(userId: String, url: String) {
        let db = Firestore.firestore()
        db.collection("users").document(userId).updateData([
            "profilePicURL": url
        ]) { error in
            if let error = error {
                print("Error updating user: \(error.localizedDescription)")
            } else {
                print("Profile picture URL successfully updated!")
            }
        }
    }
    
    func fetchProfileImageUrl(for userId: String, completion: @escaping (String?) -> Void) {
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { (document, error) in
            if let data = document?.data(), let imageUrl = data["profilePicURL"] as? String {
                completion(imageUrl)
            } else {
                completion(nil)
            }
        }
    }
}

extension AuthViewModel {
    convenience init(mockUser: User) {
        self.init()
        self.currentUser = mockUser
    }
}
