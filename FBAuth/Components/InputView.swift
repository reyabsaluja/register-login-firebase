//
//  InputView.swift
//  FBAuth
//
//  Created by Reyab Saluja on 2023-09-30.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack {
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .textFieldStyle(CustomTextFieldStyle())
                    .frame(width: 320, height: 65)
                    .padding(.top, 30)
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
                    .textFieldStyle(CustomTextFieldStyle())
                    .frame(width: 320, height: 65)
                    .padding(.top, 30)
            }
        }
    }
}

public struct CustomTextFieldStyle : TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(Font(CTFont(.label, size: 17))) // set the inner Text Field Font
            .fontWeight(.semibold)
            .padding(25) // Set the inner Text Field Padding
        //Give it some style
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color.theme.inputFieldBackground)
                )
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), placeholder: "name@example.com")
    }
}
