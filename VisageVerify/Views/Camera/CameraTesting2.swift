//
//  CameraTesting2.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 25.08.2024.
//

import SwiftUI

struct CameraTesting2: View {
    @StateObject private var cameraViewModel: CameraViewModel = .init()
    
    var body: some View {
        let cameraView = CameraView(viewModel: cameraViewModel)
        ZStack {
            Colors.blackish
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    
//                    cameraView
//                        .frame(width: 330,
//                               height: 620)
                    
                    Image("swiftCat")
                        .resizable()
                        .frame(width: 330,
                               height: 620)
                        .opacity(0.3)
                        .foregroundStyle(.blue)
                    
                    HexagonFigure(quantity: 100,
                                  blanksStrokeColor: Colors.blackish,
                                  helperColor:       Colors.blackish)
                    
                    // Display the captured image if available
                    if let image = cameraView.viewModel.capturedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .border(Color.gray, width: 2)
                            .padding(.top, 20)
                    }
                }
                
                TakePhotoButton(rectangleColor: Colors.blackish, rectangleHeight: 80, rectangleBorderColor: Colors.boneColor, rectangleBorderThickness: 3, rectangleCornerRadius: 16, mainEyeColor: Colors.boneColor, sectorColor: Colors.blackish, pupilColor: Colors.boneColor, eyeHeight: 180, paddingSize: 20, delayBetweenChangingStates: 0.015)
                
                
                
//                .simultaneousGesture(
//                    TapGesture().onEnded {
//                        cameraView.capturePhoto() // Call the capture function
//                    }
//                )
            }
            .offset(y: 20)
        }
    }
}

#Preview {
    CameraTesting2()
}
