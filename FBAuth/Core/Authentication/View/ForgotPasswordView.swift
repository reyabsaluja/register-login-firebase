//
//  ForgotPasswordView.swift
//  FBAuth
//
//  Created by Reyab Saluja on 2023-10-11.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var forgotPasswordEmail: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Text("Forgot Password?")
                .font(.title2)
                .bold()
            
            InputView(text: $forgotPasswordEmail, placeholder: "Enter Email")
            
            Button {
//                viewModel.resetPassword(withEmail: forgotPasswordEmail)
                print("Forgot password clicked")
            } label: {
                Text("Send Password Reset Email")
                    .frame(width: 320, height: 65)
                    .padding(.top, 20)
            }
            
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
