//
//  TakePhotoButton.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 25.08.2024.
//

import SwiftUI

struct TakePhotoButton: View {
    let rectangleColor:        Color
    let rectangleHeight:       CGFloat
    //let rectangleCornerRadius: CGFloat
    
    let rectangleBorderColor:     Color
    let rectangleBorderThickness: CGFloat
    let rectangleCornerRadius:    CGFloat
    
    let mainEyeColor: Color
    let sectorColor:  Color
    let pupilColor:   Color
    
    let eyeHeight: CGFloat
    
    let paddingSize: CGFloat
    
    let delayBetweenChangingStates: CGFloat //0.015
    
    @State private var isBlinking = false
    @State private var action     = false
    
    var body: some View {
        let fireflies = FloatingFireflies(quantity: 100)
        ZStack {
//            Rectangle()
//                .frame(height: rectangleHeight)
//                .foregroundStyle(rectangleColor)
//            
//                .overlay(
//                    fireflies
//                        .mask(
//                            RoundedRectangle(cornerRadius: rectangleCornerRadius)
//                                .stroke(lineWidth: rectangleBorderThickness)
//                                .padding(paddingSize)
//                        )
//                )

            fireflies
                .mask(
                    SingleBlinkingEyeView(mainEyeColor: Colors.boneColor,
                                          sectorColor:  Colors.blackish,
                                          pupilColor:   Colors.boneColor,
                                          delayBetweenChangingStates: delayBetweenChangingStates,
                                          isBlinking:   $isBlinking) // Pass the binding here
            )
            .aspectRatio(0.5, contentMode: .fit)
            .frame(height: eyeHeight)
        }
        .scaleEffect(action ? 0.95 : 1)
        .animation(.spring(duration: delayBetweenChangingStates * 8), value: action)
        .onTapGesture {
            isBlinking = true // Trigger the blinking
        }
        .onChange(of: isBlinking) {
            action.toggle()
        }
    }
}


#Preview {
    ZStack {
        Colors.blackish
            .ignoresSafeArea()
        
        TakePhotoButton(rectangleColor: Colors.blackish, rectangleHeight: 80, rectangleBorderColor: Colors.boneColor, rectangleBorderThickness: 3, rectangleCornerRadius: 16, mainEyeColor: Colors.boneColor, sectorColor: Colors.blackish, pupilColor: Colors.boneColor, eyeHeight: 180, paddingSize: 1, delayBetweenChangingStates: 0.015)
    }
}
