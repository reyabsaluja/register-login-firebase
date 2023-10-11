//
//  LoginView.swift
//  FBAuth
//
//  Created by Reyab Saluja on 2023-09-30.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var forgotPasswordViewShowing: Bool = false
    
    var body: some View {
        if !forgotPasswordViewShowing {
            NavigationStack {
                VStack {
                    
                    Text("Sign in")
                        .font(.system(size: 30, weight: .semibold))
                        .fontWeight(.bold)
                        .padding(.top, 50)
                    
                    InputView(text: $email,
                              placeholder: "Email Address")
                    .autocapitalization(.none)
                    
                    InputView(text: $password,
                              placeholder: "Password",
                              isSecureField: true)
                    .autocapitalization(.none)
                    
                    HStack {
                        rememberMe()
                        forgotPasswordButton()
                    }
                    
                    Button {
                        Task {
                            try await viewModel.signIn(withEmail: email, password: password)
                        }
                    } label: {
                        Text("Sign in")
                            .bold()
                            .frame(width: 320, height: 65)
                            .background(Color("Blue"))
                            .foregroundColor(.white)
                            .disabled(!formIsValid)
                            .opacity(formIsValid ? 1.0 : 0.5)
                            .cornerRadius(25)
                    }
                    
                    Text("Or use")
                        .foregroundColor(.gray)
                        .padding(.top, 20)
                    
                    facebook()
                    
                    Spacer()
                    
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("Don't have an account? ")
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                        + Text("Sign up")
                            .bold()
                            .foregroundColor(Color.theme.lightBlue)
                    }
                }
            }
        }
    }
}

extension LoginView {
    private func rememberMe() -> some View {
        HStack {
            Image(systemName: "square")
                .resizable()
                .foregroundColor(.gray)
                .frame(width: 25, height: 25)
                .padding(.leading, 10)
            Text("Remember me")
                .font(.headline)
                .fontWeight(.regular)
                .padding(EdgeInsets(top: 24, leading: 2, bottom: 25, trailing: 0))
        }
    }
    
    private func forgotPasswordButton() -> some View {
        ZStack {
            Button {
                //                forgotPasswordViewShowing.toggle()
                print("Forgot Password")
            } label: {
                Text("Forgot password?")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.lightBlue)
                    .padding(EdgeInsets(top: 24, leading: 15, bottom: 25, trailing: 0))
            }
            
        }
    }
    
    private func facebook() -> some View {
        Button {
            print("Signed in with facebook")
        } label: {
            Text("Facebook")
                .font(.title3)
                .bold()
                .frame(width: 320, height: 65)
                .background(Color.theme.inputFieldBackground)
                .cornerRadius(25)
                .padding(.top, 20)
        }
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthViewModel())
    }
}
