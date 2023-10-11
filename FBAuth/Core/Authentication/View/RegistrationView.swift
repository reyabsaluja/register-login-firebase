//
//  RegistrationView.swift
//  FBAuth
//
//  Created by Reyab Saluja on 2023-10-02.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email: String = ""
    @State private var fullname: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("Create Account")
                .font(.system(size: 30, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 1)
                .padding(.leading, 55)
            
            Text("Please fill the input below here")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color(.systemGray3))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
                .padding(.leading, 60)
            
            InputView(text: $email,
                      placeholder: "Email Address")
            .autocapitalization(.none)
            
            InputView(text: $fullname,
                      placeholder: "Full Name")
            
            InputView(text: $password,
                      placeholder: "Password",
                      isSecureField: true)
            .autocapitalization(.none)
            
            ZStack(alignment: .trailing) {
                InputView(text: $confirmPassword,
                          placeholder: "Confirm Password",
                          isSecureField: true)
                .autocapitalization(.none)
                
                if !password.isEmpty && !confirmPassword.isEmpty {
                    if password == confirmPassword {
                        Image(systemName: "checkmark.circle.fill")
                            .imageScale(.large)
                            .fontWeight(.bold)
                            .foregroundColor(Color(.systemGreen))
                    } else {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.large)
                            .fontWeight(.bold)
                            .foregroundColor(Color(.systemRed))
                    }
                }
            }
            
            Button {
                Task {
                    try await viewModel.createUser(withEmail: email,
                                                   password: password,
                                                   fullname: fullname)
                }
            } label: {
                Text("SIGN UP")
                    .bold()
                    .frame(width: 320, height: 65)
                    .background(Color.theme.lightBlue)
                    .foregroundColor(.white)
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
                    .cornerRadius(25)
                    .padding(.top, 25)
            }
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Text("Already have an account? ")
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                + Text("Sign in")
                    .bold()
                    .foregroundColor(Color.theme.lightBlue)
            }
        }
    }
}

extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullname.isEmpty
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
