//
//  ProfileScreen.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 04.09.2024.
//

import SwiftUI

struct ProfileScreen: View {
    @ObservedObject var registrationFormModel: RegistrationFormModel
    
    @State var settingsIsTapped: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // background
                FloatingFireflies(quantity: 100)
                    .ignoresSafeArea()
                    .frame(height: geometry.size.height / 3)
                    .position(x: geometry.size.width / 2,
                              y: geometry.safeAreaInsets.top * 2)
                
                // main body
                Circle()
                    .frame(width: geometry.size.width * 4,
                           height: geometry.size.width * 4)
                    .foregroundStyle(Colors.boneColor)
                    .position(CGPoint(x: geometry.size.width / 2,
                                      y: (geometry.size.height + geometry.safeAreaInsets.top) / 0.85))
                    // .opacity(0.3)
                
                // settings
                Button {
                    print("settings button tapped")
                    settingsIsTapped.toggle()
                } label: {
                    Image(systemName: "gearshape")
                        .resizable()
                        .scaledToFill()
                        .rotationEffect(Angle(degrees: settingsIsTapped ? 720 : 0))
                        .frame(width: geometry.size.width / 12,
                               height: geometry.size.width / 12)
                        .position(CGPoint(x: geometry.size.width * 0.9,
                                          y: geometry.safeAreaInsets.top / 2))
                        .foregroundStyle(Colors.blackish)
                        //.shadow(color: Colors.boneColor, radius: 10)
                        .animation(.spring, value: settingsIsTapped)
                }
                
                // user name
                PrettyText(text: registrationFormModel.user.username,
                           color: Colors.blackish,
                           fontSize: (geometry.size.height + geometry.safeAreaInsets.top) / 20)
                    .position(CGPoint(x: geometry.size.width / 2,
                                      y: (geometry.size.height + geometry.safeAreaInsets.top) / 2.9))
                
                // real name
                PrettyText(text: registrationFormModel.user.realName, 
                           color: Colors.blackish,
                           fontSize: (geometry.size.height + geometry.safeAreaInsets.top) / 30)
                    .position(CGPoint(x: geometry.size.width / 2,
                                      y: (geometry.size.height + geometry.safeAreaInsets.top) / 2.5))
                    .opacity(0.5)
                
                // qr-code
                Image("qr-code")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width / 1.3,
                           height: geometry.size.width / 1.3)
                    .position(CGPoint(x: geometry.size.width / 2,
                                      y: (geometry.size.height + geometry.safeAreaInsets.top) / 1.5))
                
                // profile image
                ProfilePictureView(registrationFormModel: registrationFormModel,
                                   width: geometry.size.width / 3.5,
                                   height: geometry.size.width / 3.5)
//                    .frame(width:  geometry.size.width / 3.5,
//                           height: geometry.size.width / 3.5)
//                    .foregroundStyle(.red)
                    .position(CGPoint(x: geometry.size.width / 2,
                                      y: (geometry.size.height + geometry.safeAreaInsets.top) / 4.5))
            }
            .navigationBarBackButtonHidden(true) // Hide the default back button
        }
    }
}

#Preview {
    @ObservedObject var registrationFormModel: RegistrationFormModel = .init()

    return ProfileScreen(registrationFormModel: registrationFormModel)
}
