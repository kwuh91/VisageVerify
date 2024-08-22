//
//  RegistrationForm.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 18.08.2024.
//

import SwiftUI

struct RegistrationForm: View {
    
    @ObservedObject var registrationFormModel: RegistrationFormModel = .init()
    
    @State private var readyToNavigate : Bool = false
    
    let color:              Color = Colors.blackish
    let bottomPadding:      CGFloat = 10
    let fontName:           String = "ArsenalSC-Regular"
    let errorFontSize :     CGFloat = 17.5
    let errorFontColor:     Color = Color(hex: "c1121f")
    let errorMessageOffset: CGFloat = -15
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    Colors.boneColor
                        .ignoresSafeArea()
                    
                    // vertical stack with fields for:
                    // real name, email, password, checking password and register button
                    VStack(spacing: -5) {
                        // real name
                        Group {
                            // input field
                            TextField("", text: $registrationFormModel.user.realName)
                                .placeholder(when: registrationFormModel.user.realName.isEmpty) {
                                    Text("Your Name").foregroundColor(Colors.blackish)
                                }
                                .textContentType(.givenName)
                                .autocapitalization(.words)
                                .underlineTextField(color:         color,
                                                    fontSize:      26,
                                                    bottomPadding: bottomPadding)
                            
                            // error message
                            Text(registrationFormModel.invalidRealName)
                                .font(.custom(fontName, size: errorFontSize))
                                .foregroundColor(errorFontColor)
                                .offset(y: errorMessageOffset)
                        }
                        .animation(.spring,
                                   value: registrationFormModel.invalidRealName.isEmpty)
                        
                        // username
                        Group {
                            // input field
                            TextField("", text: $registrationFormModel.user.username)
                                .placeholder(when: registrationFormModel.user.username.isEmpty) {
                                    Text("Username").foregroundColor(Colors.blackish)
                                }
                                .textContentType(.nickname)
                                .autocapitalization(.none)
                                .underlineTextField(color:         color,
                                                    fontSize:      26,
                                                    bottomPadding: bottomPadding)
                            
                            // error message
                            Text(registrationFormModel.invalidUsername)
                                .font(.custom(fontName, size: errorFontSize))
                                .foregroundColor(errorFontColor)
                                .offset(y: errorMessageOffset)
                        }
                        .animation(.spring,
                                   value: registrationFormModel.invalidUsername.isEmpty)
                        
                        // email address
                        Group {
                            // input field
                            TextField("", text: $registrationFormModel.user.email)
                                .placeholder(when: registrationFormModel.user.email.isEmpty) {
                                    Text("Email Address").foregroundColor(Colors.blackish)
                                }
                                .textContentType(.emailAddress)
                                .autocapitalization(.none)
                                .underlineTextField(color:         color,
                                                    fontSize:      26,
                                                    bottomPadding: bottomPadding)
                            
                            // error message
                            Text(registrationFormModel.invalidEmail)
                                .font(.custom(fontName, size: errorFontSize))
                                .foregroundColor(errorFontColor)
                                .offset(y: errorMessageOffset)
                        }
                        .animation(.spring,
                                   value: registrationFormModel.invalidEmail.isEmpty)
                        
                        // password
                        Group {
                            // main password
                            Group {
                                SecureField("", text: $registrationFormModel.user.password)
                                    .placeholder(when: registrationFormModel.user.password.isEmpty) {
                                        Text("Password").foregroundColor(Colors.blackish)
                                    }
                                    .textContentType(.newPassword)
                                    .underlineTextField(color:         color,
                                                        fontSize:      26,
                                                        bottomPadding: bottomPadding)
                                
                                // error message for main password
                                Text(registrationFormModel.invalidPassword)
                                    .font(.custom(fontName, size: errorFontSize))
                                    .foregroundColor(errorFontColor)
                                    .offset(y: errorMessageOffset)
                            }
                            .animation(.spring,
                                       value: registrationFormModel.invalidPassword.isEmpty)
                            
                            // check password
                            Group{
                                SecureField("", text: $registrationFormModel.checkPassword)
                                    .placeholder(when: registrationFormModel.checkPassword.isEmpty) {
                                        Text("Repeat password").foregroundColor(Colors.blackish)
                                    }
                                    .textContentType(.newPassword)
                                    .underlineTextField(color:         color,
                                                        fontSize:      26,
                                                        bottomPadding: bottomPadding)
                                
                                // error message for check password
                                Text(registrationFormModel.invalidCheckPassword)
                                    .font(.custom(fontName, size: errorFontSize))
                                    .foregroundColor(errorFontColor)
                                    .offset(y: errorMessageOffset)
                            }
                            .animation(.spring,
                                       value: registrationFormModel.invalidCheckPassword.isEmpty)
                        }
                        
                        // continue button
                        Group {
                            Button {
                                if registrationFormModel.allGood {
                                    readyToNavigate.toggle()
                                }
                            } label: {
                                PrettyText(text:     "Continue",
                                           color:    Colors.blackish,
                                           fontSize: 35)
                                .opacity(registrationFormModel.allGood ? 1 : 0.3)
                            }
                        }
                        .offset(y: ((geometry.size.height + geometry.safeAreaInsets.top) / 9.5))
                        .navigationDestination(isPresented: $readyToNavigate) {
                            Testing2(registrationFormModel: registrationFormModel)
                        }
                        .animation(.spring,
                                   value: registrationFormModel.allGood)
                        
                        if let errorMessage = registrationFormModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.footnote)
                        }
                        
                    }
                    .offset(y: -20)
                    .padding()
                }
            }
        }
    }
}
    
extension View {
    func placeholder<Content: View>(when shouldShow: Bool,
                                    alignment: Alignment = .center,
                                    @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 0.3 : 0)
            self
        }
    }
}

#Preview {
    RegistrationForm(registrationFormModel: .init())
}
