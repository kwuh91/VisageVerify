//
//  RegistrationForm.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 18.08.2024.
//

import SwiftUI

// singleton
//class userData {
//    static let user = userData()
//    
//    private init() { }
//    
//    var data: User = .init()
//}

class BackButtonTapState: ObservableObject {
    @Published var isButtonTapped: Int
    
    init(isButtonTapped: Int = 0) {
        self.isButtonTapped = isButtonTapped
    }
}

struct RegistrationForm: View {
    
    @ObservedObject var registrationFormModel: RegistrationFormModel = .init()
    
    @State private var readyToNavigate : Bool = false
    
    @State private var isBlinking = false
    
    let color:              Color = Colors.blackish
    let bottomPadding:      CGFloat = 10
    let fontName:           String = "ArsenalSC-Regular"
    let errorFontSize :     CGFloat = 17.5
    let errorFontColor:     Color = Color(hex: "c1121f")
    let errorMessageOffset: CGFloat = -15
    
    let textFieldAppearAnimationDuration:    CGFloat = 1.5
    let textFieldDisappearAnimationDuration: CGFloat = 1.5
    let textFieldAppearAnimationDelay:       CGFloat = 1.5
    let textFieldDisappearAnimationDelay:    CGFloat = 0.0
    
    @ObservedObject var backButtonTapState: BackButtonTapState
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    // background color
                    Colors.boneColor
                        .ignoresSafeArea()
                    
                    // vertical stack with fields for:
                    // real name, username, email, password, checking password and continue button
                    VStack(spacing: -5) {
                        // back button (eye)
                        SingleBlinkingEyeView(mainEyeColor: .black,
                                              sectorColor:  .white,
                                              pupilColor:   .black,
                                              delayBetweenChangingStates: 0.015, 
                                              isBlinking:   $isBlinking)
                            .aspectRatio(0.5, contentMode: .fit)
                            .frame(height: 200)
                            .onTapGesture {
                                // allow tap gesture only if registration screen is present
                                
                                // backButtonTapState.isButtonTapped += 1
                                if backButtonTapState.isButtonTapped % 2 != 0 {
                                    isBlinking = true
                                    backButtonTapState.isButtonTapped += 1
                                }
                            }
                        
                        // real name
                        Group {
                            // input field
                            TextField("", text: $registrationFormModel.user.realName)
                                .placeholder(when: registrationFormModel.user.realName.isEmpty) {
                                    Text("Your Name").foregroundColor(Colors.blackish)
                                }
                                .textContentType(.givenName)
                                .autocapitalization(.words)
                                .foregroundStyle(Colors.blackish)
                                .underlineTextField(
                                    color: registrationFormModel.invalidRealName.isEmpty
                                                ? color
                                                : errorFontColor,
                                    fontSize:      26,
                                    bottomPadding: bottomPadding)
                                .offset(x: backButtonTapState.isButtonTapped % 2 != 0
                                            ? 0
                                            : geometry.size.width)
                            
                            // error message
                            Text(registrationFormModel.invalidRealName)
                                .font(.custom(fontName, size: errorFontSize))
                                .foregroundColor(errorFontColor)
                                .offset(y: errorMessageOffset)
                        }
                        // animation for error message
                        .animation(.spring,
                                   value: registrationFormModel.invalidRealName.isEmpty)
                        // animation for text field appearing/disappearing
                        .animation(
                            .spring(
                                duration: backButtonTapState.isButtonTapped % 2 != 0
                                            ? textFieldAppearAnimationDuration
                                            : textFieldDisappearAnimationDuration)
                                .delay( backButtonTapState.isButtonTapped % 2 != 0
                                            ? textFieldAppearAnimationDelay
                                            : textFieldDisappearAnimationDelay),
                                value: backButtonTapState.isButtonTapped)
                        
                        // username
                        Group {
                            // input field
                            TextField("", text: $registrationFormModel.user.username)
                                .placeholder(when: registrationFormModel.user.username.isEmpty) {
                                    Text("Username").foregroundColor(Colors.blackish)
                                }
                                .textContentType(.nickname)
                                .autocapitalization(.none)
                                .foregroundStyle(Colors.blackish)
                                .underlineTextField(
                                    color: registrationFormModel.invalidUsername.isEmpty
                                                ? color
                                                : errorFontColor,
                                    fontSize:      26,
                                    bottomPadding: bottomPadding)
                                .offset(x: backButtonTapState.isButtonTapped % 2 != 0
                                            ? 0
                                            : -geometry.size.width)
                            
                            // error message
                            Text(registrationFormModel.invalidUsername)
                                .font(.custom(fontName, size: errorFontSize))
                                .foregroundColor(errorFontColor)
                                .offset(y: errorMessageOffset)
                        }
                        // animation for error message
                        .animation(.spring,
                                   value: registrationFormModel.invalidUsername.isEmpty)
                        // animation for text field appearing/disappearing
                        .animation(
                            .spring(
                                duration: backButtonTapState.isButtonTapped % 2 != 0
                                            ? textFieldAppearAnimationDuration
                                            : textFieldDisappearAnimationDuration)
                                .delay( backButtonTapState.isButtonTapped % 2 != 0
                                            ? textFieldAppearAnimationDelay
                                            : textFieldDisappearAnimationDelay),
                                value: backButtonTapState.isButtonTapped)
                        
                        // email address
                        Group {
                            // input field
                            TextField("", text: $registrationFormModel.user.email)
                                .placeholder(when: registrationFormModel.user.email.isEmpty) {
                                    Text("Email Address").foregroundColor(Colors.blackish)
                                }
                                .textContentType(.emailAddress)
                                .autocapitalization(.none)
                                .foregroundStyle(Colors.blackish)
                                .underlineTextField(
                                    color: registrationFormModel.invalidEmail.isEmpty
                                                ? color
                                                : errorFontColor,
                                    fontSize:      26,
                                    bottomPadding: bottomPadding)
                                .offset(x: backButtonTapState.isButtonTapped % 2 != 0
                                            ? 0
                                            : geometry.size.width)
                            
                            // error message
                            Text(registrationFormModel.invalidEmail)
                                .font(.custom(fontName, size: errorFontSize))
                                .foregroundColor(errorFontColor)
                                .offset(y: errorMessageOffset)
                        }
                        // animation for error message
                        .animation(.spring,
                                   value: registrationFormModel.invalidEmail.isEmpty)
                        // animation for text field appearing/disappearing
                        .animation(
                            .spring(
                                duration: backButtonTapState.isButtonTapped % 2 != 0
                                            ? textFieldAppearAnimationDuration
                                            : textFieldDisappearAnimationDuration)
                                .delay( backButtonTapState.isButtonTapped % 2 != 0
                                            ? textFieldAppearAnimationDelay
                                            : textFieldDisappearAnimationDelay),
                                value: backButtonTapState.isButtonTapped)
                        
                        // password
                        Group {
                            // main password
                            Group {
                                SecureField("", text: $registrationFormModel.user.password)
                                    .placeholder(when: registrationFormModel.user.password.isEmpty) {
                                        Text("Password").foregroundColor(Colors.blackish)
                                    }
                                    .textContentType(.newPassword)
                                    .foregroundStyle(Colors.blackish)
                                    .underlineTextField(
                                        color: registrationFormModel.invalidPassword.isEmpty
                                                    ? color
                                                    : errorFontColor,
                                        fontSize:      26,
                                        bottomPadding: bottomPadding)
                                    .offset(x: backButtonTapState.isButtonTapped % 2 != 0
                                                ? 0
                                                : -geometry.size.width)
                                
                                // error message for main password
                                Text(registrationFormModel.invalidPassword)
                                    .font(.custom(fontName, size: errorFontSize))
                                    .foregroundColor(errorFontColor)
                                    .offset(y: errorMessageOffset)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            // animation for error message
                            .animation(.spring,
                                       value: registrationFormModel.invalidPassword.isEmpty)
                            // animation for text field appearing/disappearing
                            .animation(
                                .spring(
                                    duration: backButtonTapState.isButtonTapped % 2 != 0
                                                ? textFieldAppearAnimationDuration
                                                : textFieldDisappearAnimationDuration)
                                    .delay( backButtonTapState.isButtonTapped % 2 != 0
                                                ? textFieldAppearAnimationDelay
                                                : textFieldDisappearAnimationDelay),
                                    value: backButtonTapState.isButtonTapped)
                            
                            // check password
                            Group{
                                SecureField("", text: $registrationFormModel.checkPassword)
                                    .placeholder(when: registrationFormModel.checkPassword.isEmpty) {
                                        Text("Repeat Password").foregroundColor(Colors.blackish)
                                    }
                                    .textContentType(.newPassword)
                                    .foregroundStyle(Colors.blackish)
                                    .underlineTextField(
                                        color: registrationFormModel.invalidCheckPassword.isEmpty
                                                    ? color
                                                    : errorFontColor,
                                        fontSize:      26,
                                        bottomPadding: bottomPadding)
                                    .offset(x: backButtonTapState.isButtonTapped % 2 != 0
                                                ? 0
                                                : geometry.size.width)
                                
                                // error message for check password
                                Text(registrationFormModel.invalidCheckPassword)
                                    .font(.custom(fontName, size: errorFontSize))
                                    .foregroundColor(errorFontColor)
                                    .offset(y: errorMessageOffset)
                            }
                            // animation for error message
                            .animation(.spring,
                                       value: registrationFormModel.invalidCheckPassword.isEmpty)
                            // animation for text field appearing/disappearing
                            .animation(
                                .spring(
                                    duration: backButtonTapState.isButtonTapped % 2 != 0
                                                ? textFieldAppearAnimationDuration
                                                : textFieldDisappearAnimationDuration)
                                    .delay( backButtonTapState.isButtonTapped % 2 != 0
                                                ? textFieldAppearAnimationDelay
                                                : textFieldDisappearAnimationDelay),
                                    value: backButtonTapState.isButtonTapped)
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
                            .disabled(!registrationFormModel.allGood)
                        }
                        .offset(y: ((geometry.size.height + geometry.safeAreaInsets.top) / 9.5))
                        .navigationDestination(isPresented: $readyToNavigate) {
                            // Testing2(registrationFormModel: registrationFormModel)
                            
                            RegistrationCameraScreen(registrationFormModel: registrationFormModel)
                            // CameraTesting3(registrationFormModel: registrationFormModel)
                        }
                        // animation for enabling continue button
                        .animation(.spring,
                                   value: registrationFormModel.allGood)
                        
                        // unexpected warning message
                        if let errorMessage = registrationFormModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.footnote)
                        }
                        
                        // move everything up a little
                        Spacer()
                            .frame(height: 150)
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
    @StateObject var RegistrationFormViewBackButtonTapState = BackButtonTapState(isButtonTapped: 1)
    
    return RegistrationForm(registrationFormModel: .init(),
                            backButtonTapState: RegistrationFormViewBackButtonTapState)
}
