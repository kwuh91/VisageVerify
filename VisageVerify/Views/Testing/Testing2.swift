//
//  Testing2.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 05.08.2024.
//

import SwiftUI

//struct Testing2: View {
//    
//    @State private var action  = false
//    @State private var pulsate = false
//    
//    var body: some View {
//        ZStack {
//            // background color
//            Colors.boneColor
//                .ignoresSafeArea()
//                
//            // main body
//            ZStack {
//                // eye 1
//                Icon(iconName:   "eye.fill",
//                     iconColor:  .black,
//                     iconSize:   70,
//                     fontWeight: .thin)
//                .rotationEffect(action ? Angle(degrees: 270) : Angle(degrees: 0))
//                .scaleEffect(action ? 5.9 : 1)
//                
//                Circle()
//                    .frame(height: action ? 30 * 4.1 : 0) // 20 -> 30
//                    .foregroundStyle(Colors.boneColor)
//                
//                // eye 2
//                Icon(iconName:   "eye.fill",
//                     iconColor:  .black,
//                     iconSize:   action ? 165 : 1,
//                     fontWeight: .thin)
//                .rotationEffect(action ? Angle(degrees: 180) : Angle(degrees: 0))
//                
//                Circle()
//                    .frame(height: action ? 30 * 1.5 : 0) // 20 -> 30
//                    .foregroundStyle(Colors.boneColor)
//                
//                // eye 3
//                Icon(iconName:   "eye.fill",
//                     iconColor:  .black,
//                     iconSize:   action ? 55 : 1,
//                     fontWeight: .thin)
//                .rotationEffect(action ? Angle(degrees: 90) : Angle(degrees: 0))
//                
//                Circle()
//                    .frame(height: action ? 30 * 0.5 : 0) // 20 -> 30
//                    .foregroundStyle(Colors.boneColor)
//                
//                // eye 3
//                Icon(iconName:   "eye.fill",
//                     iconColor:  .black,
//                     iconSize:   action ? 15 : 1,
//                     fontWeight: .thin)
//
//            }
//            .onTapGesture {
//                // rotate
//                // scale
//                // color
//                withAnimation (
//                    Animation.easeInOut(
//                        duration: 2
//                    )
//                ){
//                    action.toggle()
//                }
//                
//                // pulsate
//                withAnimation(
//                    Animation.easeInOut(
//                        duration: 2
//                    ).repeatForever(autoreverses: true).delay(1)
//                ){
//                    pulsate.toggle()
//                }
//            }
//        }
//    }
//}

//struct Testing2: View {
//    
//    @State private var action  = false
//    
//    var body: some View {
//        ZStack {
//            // background color
//            Colors.boneColor
//                .edgesIgnoringSafeArea(.all)
//            
//            Testing()
//                .opacity(action ? 1 : 0)
//                //.scaleEffect(action ? 1 : 0)
//        }
//        .onTapGesture {
//            withAnimation (
//                Animation.easeInOut(
//                    duration: 3
//                )
//            ){
//                action.toggle()
//            }
//        }
//    }
//}
//
//
//
//#Preview {
//    Testing2()
//}

struct Testing2: View {
    @ObservedObject var registrationFormModel: RegistrationFormModel
    
    var body: some View {
        VStack {
            Text("Entered Data")
            
            Text("realName: \(registrationFormModel.user.realName)")

            Text("username: \(registrationFormModel.user.username)")
            
            Text("email: \(registrationFormModel.user.email)")
            
            Text("pasword: \(registrationFormModel.user.password)")

            Text("biometry: \(registrationFormModel.user.biometry)")
            
            Button("Register") {
                registrationFormModel.registerUser()
                
                debugPrint("register button tapped!")
            }
            .disabled(!registrationFormModel.allGood)
            .foregroundColor(.blue)
        }
    }
}
