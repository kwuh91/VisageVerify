//
//  RegistrationForm.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 18.08.2024.
//

import SwiftUI

struct RegistrationForm: View {
    
    @ObservedObject var formModel: FormModel = .init()
    
    var body: some View {
        // vertical stack with fields for:
        // mail, password, checking password and register button
        VStack {
            // mail address
            Group {
                // input field
                TextField
                    .init("mail address", text: $formModel.mail)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                
                // error message
                if !formModel.invalidMail.isEmpty {
                    Text(formModel.invalidMail)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
            }
            
            // password
            Group {
                // main password
                SecureField
                    .init("password", text: $formModel.pass)
                    .textContentType(.newPassword)
                
                // check password
                SecureField
                    .init("retype password", text: $formModel.retype)
                    .textContentType(.newPassword)

                // error message
                if !formModel.invalidPass.isEmpty {
                    Text(formModel.invalidPass)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
            }
            
            // register button
            Button("Register") {
                debugPrint("register")
            }
            .disabled(!formModel.canSend)
            .foregroundColor(.blue)
            
            Spacer()
            
        }
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

#Preview {
    RegistrationForm(formModel: .init())
}
