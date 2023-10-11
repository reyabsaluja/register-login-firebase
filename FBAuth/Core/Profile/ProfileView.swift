//
//  ProfileView.swift
//  FBAuth
//
//  Created by Reyab Saluja on 2023-10-02.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    
    //  State variables for managing the profile image selection and display.
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false
    @State private var profileImageUrl: String? = nil
    
    //  Environment object for the user's authentication data.
    @EnvironmentObject var viewModel: AuthViewModel
    
    //  Observable object to manage loading the profile image.
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        
        if let user = viewModel.currentUser {
            
            List {
                
                profileSection(for: user)                       //  User's profile section with image and name.
                generalSection()                                //  General settings like the app version.
                accountSection()                                //  Account management actions (sign out, delete).
                changeProfilePictureSection(for: user)          //  Option to change the profile picture.
                
            }
            .onAppear {
                uploadProfilePicture(for: user)                 //  Fetch and load the profile image URL on view appear.
            }
            .sheet(isPresented: $isImagePickerPresented, content: {
                ImagePicker(selectedImage: $selectedImage)      //  Display the image picker when tapped.
            })
        }
    }
}

// MARK: - Private Functions

extension ProfileView {
    
    /// The section displaying user's profile image and basic information.
    private func profileSection(for user: User) -> some View {
        Section {
            HStack {
                
                profilePicture
                    .padding(.trailing, 10)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.fullname).fontWeight(.semibold).padding(.top, 4)
                    Text(user.email).font(.footnote).foregroundColor(.gray)
                }
            }
        }
    }
    
    /// The general section displaying app information.
    private func generalSection() -> some View {
        Section("General") {
            
            HStack {
                SettingsRowViews(imageName: "gear",
                                 title: "Version",
                                 tintColor: Color(.systemGray))
                
                Spacer()
                
                Text("1.0.0")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
    
    /// The account management section.
    private func accountSection() -> some View {
        Section("Account") {
            
            Button {
                viewModel.signOut()                         //  Signs user out from FireBase Auth
            } label: {
                SettingsRowViews(imageName: "arrow.left.circle.fill",
                                 title: "Sign Out",
                                 tintColor: .red)
            }
            
            Button {
                viewModel.deleteAccount()                   //  Deletes user's account
            } label: {
                SettingsRowViews(imageName: "xmark.circle.fill",
                                 title: "Delete Account",
                                 tintColor: .red)
            }
        }
    }
    
    private func changeProfilePictureSection(for user: User) -> some View {
        Button {
            if let image = selectedImage {
                viewModel.uploadProfilePicture(image: image) { url in
                    if let url = url {
                        viewModel.updateProfilePictureURL(userId: user.id, url: url)    /*  Updates user's profile picture via                                                                               AuthViewModel's function */
                    }
                }
            }
        } label : {
            Text("Change Profile Picture")
                .bold()
                .frame(width: 320, height: 65)
                .background(Color.theme.lightBlue)
                .foregroundColor(.white)
                .cornerRadius(25)
                .padding(.top, 25)
        }
    }
    
    /// The user's profile image. It can be either the selected, loaded or default image.
    private var profilePicture: some View {
        ZStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .userProfileModifier()                       //  Apply common image styling.
                    .onTapGesture {
                        isImagePickerPresented.toggle()
                    }
            } else if imageLoader.image != nil {
                Image(uiImage: imageLoader.image!)
                    .userProfileModifier()
                    .onTapGesture {
                        isImagePickerPresented.toggle()
                    }
            } else if imageLoader.isLoading {
                ProgressView()                                  //  Display a loading indicator if image is being fetched.
            } else {
                ZStack(alignment: .bottomTrailing) {
                    Image(systemName: "person.circle.fill")
                        .userProfileModifier()
                        .onTapGesture {
                            isImagePickerPresented.toggle()     //  Show image picker when tapped.
                        }
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.blue)
                        .mask(
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.black)
                        )
                        .background(Color.white)
                        .clipShape(Circle())
                }
            }
        }
    }
    
    /// Load the image URL for a specific user.
    private func uploadProfilePicture(for user: User) {
        viewModel.fetchProfileImageUrl(for: user.id) { imageUrl in
            if let imageUrl = imageUrl {
                print("Fetched Image URL: \(imageUrl)")
                if let url = URL(string: imageUrl) {
                    imageLoader.load(from: url)             // Use ImageLoader to asynchronously load the image.
                }
            } else {
                print("No Image URL received from userDataManager")
            }
        }
    }
}

/// Quick image formatting
extension Image {
    func userProfileModifier() -> some View {
        self
            .resizable()
            .frame(width: 72, height: 72)
            .clipShape(Circle())
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(AuthViewModel(mockUser: User(fullname: "John Doe", email: "johndoe@gmail.com")))
    }
}
