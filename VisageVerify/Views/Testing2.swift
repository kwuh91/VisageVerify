//
//  Testing2.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 05.08.2024.
//

import SwiftUI

struct Testing2: View {
    
    @State private var action  = false
    @State private var pulsate = false
    
    var body: some View {
        ZStack {
            // background color
            Colors.boneColor
                .ignoresSafeArea()
                
            // main body
            ZStack {
                // eye 1
                Icon(iconName:   "eye.fill",
                     iconColor:  .black,
                     iconSize:   70,
                     fontWeight: .thin)
                .rotationEffect(action ? Angle(degrees: 270) : Angle(degrees: 0))
                .scaleEffect(action ? 5.9 : 1)
                
                Circle()
                    .frame(height: action ? 30 * 4.1 : 0) // 20 -> 30
                    .foregroundStyle(Colors.boneColor)
                
                // eye 2
                Icon(iconName:   "eye.fill",
                     iconColor:  .black,
                     iconSize:   action ? 165 : 1,
                     fontWeight: .thin)
                .rotationEffect(action ? Angle(degrees: 180) : Angle(degrees: 0))
                
                Circle()
                    .frame(height: action ? 30 * 1.5 : 0) // 20 -> 30
                    .foregroundStyle(Colors.boneColor)
                
                // eye 3
                Icon(iconName:   "eye.fill",
                     iconColor:  .black,
                     iconSize:   action ? 55 : 1,
                     fontWeight: .thin)
                .rotationEffect(action ? Angle(degrees: 90) : Angle(degrees: 0))
                
                Circle()
                    .frame(height: action ? 30 * 0.5 : 0) // 20 -> 30
                    .foregroundStyle(Colors.boneColor)
                
                // eye 3
                Icon(iconName:   "eye.fill",
                     iconColor:  .black,
                     iconSize:   action ? 15 : 1,
                     fontWeight: .thin)

            }
            .onTapGesture {
                // rotate
                // scale
                // color
                withAnimation (
                    Animation.easeInOut(
                        duration: 2
                    )
                ){
                    action.toggle()
                }
                
                // pulsate
                withAnimation(
                    Animation.easeInOut(
                        duration: 2
                    ).repeatForever(autoreverses: true).delay(1)
                ){
                    pulsate.toggle()
                }
            }
        }
    }
}

#Preview {
    Testing2()
}
