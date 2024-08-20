//
//  RegistrationForm.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 18.08.2024.
//

import SwiftUI

struct RegistrationForm: View {
    
    @ObservedObject var registrationFormModel: RegistrationFormModel = .init()
    
    var body: some View {
        // vertical stack with fields for:
        // real name, email, password, checking password and register button
        VStack {
            // real name
            Group {
                // input field
                TextField
                    .init("Your Name", text: $registrationFormModel.user.realName)
                    .textContentType(.givenName)
                    .autocapitalization(.words)
                
                // error message
                if !registrationFormModel.invalidRealName.isEmpty {
                    Text(registrationFormModel.invalidRealName)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
            }
            
            // username
            Group {
                // input field
                TextField
                    .init("Username", text: $registrationFormModel.user.username)
                    .textContentType(.givenName)
                    .autocapitalization(.words)
                
                // error message
                if !registrationFormModel.invalidUsername.isEmpty {
                    Text(registrationFormModel.invalidUsername)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
            }
            
            // email address
            Group {
                // input field
                TextField
                    .init("Email Address", text: $registrationFormModel.user.email)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                
                // error message
                if !registrationFormModel.invalidEmail.isEmpty {
                    Text(registrationFormModel.invalidEmail)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
            }
            
            // password
            Group {
                // main password
                SecureField
                    .init("Password", text: $registrationFormModel.user.password)
                    .textContentType(.newPassword)
                
                // error message for main password
                if !registrationFormModel.invalidPassword.isEmpty {
                    Text(registrationFormModel.invalidPassword)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                
                // check password
                SecureField
                    .init("repeat password", text: $registrationFormModel.checkPassword)
                    .textContentType(.newPassword)

                // error message for check password
                if !registrationFormModel.invalidCheckPassword.isEmpty {
                    Text(registrationFormModel.invalidCheckPassword)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
            }
            
            // register button
            Button("Register") {
                registrationFormModel.registerUser()
                
                debugPrint("register button tapped!")
            }
            .disabled(!registrationFormModel.allGood)
            .foregroundColor(.blue)
            
            if let errorMessage = registrationFormModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            
            Spacer()
            
        }
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

#Preview {
    RegistrationForm(registrationFormModel: .init())
}
