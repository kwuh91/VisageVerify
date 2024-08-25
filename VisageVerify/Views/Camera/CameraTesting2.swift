//
//  CameraTesting2.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 25.08.2024.
//

import SwiftUI

struct CameraTesting2: View {
    @StateObject private var cameraViewModel: CameraViewModel = .init()
    
    @State private var isBlinking1 = false
    @State private var isBlinking2 = false
    @State private var isBlinking3 = false
    @State private var isBlinking4 = false
    @State private var isBlinking5 = false
    
    var body: some View {
        let cameraView = CameraView(viewModel: cameraViewModel)
        ZStack {
            Colors.blackish
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    
                    cameraView
                        .frame(width: 330,
                               height: 620)
                    

                    
                    HexagonFigure(quantity: 100,
                                  blanksStrokeColor: Colors.blackish,
                                  helperColor:       Colors.blackish)
                    // back eyes
                    Group {
                        Group {
                            SingleBlinkingEyeView(mainEyeColor: Colors.boneColor,
                                                  sectorColor:  Colors.blackish,
                                                  pupilColor:   Colors.boneColor,
                                                  delayBetweenChangingStates: 0.015,
                                                  isBlinking:   $isBlinking1)
                                .aspectRatio(0.5, contentMode: .fit)
                                .frame(height: 200)
                                .rotationEffect(Angle(degrees: 90))
                                .offset(x: -105)
                            
                        }
                        .offset(x: -70,y: -120)
                        .onTapGesture {
                            isBlinking1 = true
                        }
                        
                        Group {
                            SingleBlinkingEyeView(mainEyeColor: Colors.boneColor,
                                                  sectorColor:  Colors.blackish,
                                                  pupilColor:   Colors.boneColor,
                                                  delayBetweenChangingStates: 0.015,
                                                  isBlinking:   $isBlinking2)
                                .aspectRatio(0.5, contentMode: .fit)
                                .frame(height: 200)
                                .rotationEffect(Angle(degrees: 270))
                                .offset(x: -105)
                            
                        }
                        .offset(x: 280,y: -240)
                        .onTapGesture {
                            isBlinking2 = true
                        }
                        
                        Group {
                            SingleBlinkingEyeView(mainEyeColor: Colors.boneColor,
                                                  sectorColor:  Colors.blackish,
                                                  pupilColor:   Colors.boneColor,
                                                  delayBetweenChangingStates: 0.015,
                                                  isBlinking:   $isBlinking3)
                                .aspectRatio(0.5, contentMode: .fit)
                                .frame(height: 200)
                                .rotationEffect(Angle(degrees: 90))
                                .offset(x: -105)
                            
                        }
                        .offset(x: -70,y: 120)
                        .onTapGesture {
                            isBlinking3 = true
                        }
                        
                        Group {
                            SingleBlinkingEyeView(mainEyeColor: Colors.boneColor,
                                                  sectorColor:  Colors.blackish,
                                                  pupilColor:   Colors.boneColor,
                                                  delayBetweenChangingStates: 0.015,
                                                  isBlinking:   $isBlinking4)
                                .aspectRatio(0.5, contentMode: .fit)
                                .frame(height: 200)
                                .rotationEffect(Angle(degrees: 270))
                                .offset(x: -105)
                            
                        }
                        .offset(x: 280)
                        .onTapGesture {
                            isBlinking4 = true
                        }
                        
                        Group {
                            SingleBlinkingEyeView(mainEyeColor: Colors.boneColor,
                                                  sectorColor:  Colors.blackish,
                                                  pupilColor:   Colors.boneColor,
                                                  delayBetweenChangingStates: 0.015,
                                                  isBlinking:   $isBlinking5)
                                .aspectRatio(0.5, contentMode: .fit)
                                .frame(height: 200)
                                .rotationEffect(Angle(degrees: 270))
                                .offset(x: -105)
                            
                        }
                        .offset(x: 280, y: 240)
                        .onTapGesture {
                            isBlinking5 = true
                        }
                    }
                    
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
                
                .simultaneousGesture(
                    TapGesture().onEnded {
                        cameraView.capturePhoto() // Call the capture function
                    }
                )
            }
            .offset(y: 20)
        }
    }
}

#Preview {
    CameraTesting2()
}

////
////  CameraTesting2.swift
////  VisageVerify
////
////  Created by Nikita Ochkin on 25.08.2024.
////
//
//import SwiftUI
//
//struct CameraTesting2: View {
//    @StateObject private var cameraViewModel: CameraViewModel = .init()
//    
//    private let eyeOffsets: [(x: CGFloat, y: CGFloat, rotation: Double)] = [
//        (-70, -120, 90 ),
//        (280, -240, 270),
//        (-70, 120,  90 ),
//        (280, 0,    270),
//        (280, 240,  270)
//    ]
//    
//    @State private var isBlinkingStates = Array(repeating: false, count: 5)
//    
//    var body: some View {
//        let cameraView = CameraView(viewModel: cameraViewModel)
//        ZStack {
//            Colors.blackish
//                .ignoresSafeArea()
//            
//            VStack {
//                ZStack {
//                    cameraView
//                        .frame(width: 330, height: 620)
//                    
////                                        Image("swiftCat")
////                                            .resizable()
////                                            .frame(width: 330,
////                                                   height: 620)
////                                            .opacity(0.3)
//                    //                        .foregroundStyle(.blue)
//                    
//                    HexagonFigure(quantity: 100,
//                                  blanksStrokeColor: Colors.blackish,
//                                  helperColor:       Colors.blackish)
//                    
//                    // back eyes
//                    ForEach(0..<5) { index in
//                        createBackEys(index: index)
//                    }
//                    
//                    // Display the captured image if available
//                    if let image = cameraView.viewModel.capturedImage {
//                        Image(uiImage: image)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 300, height: 300)
//                            .border(Color.gray, width: 2)
//                            .padding(.top, 20)
//                    }
//                }
//                
//                TakePhotoButton(
//                    rectangleColor: Colors.blackish,
//                    rectangleHeight: 80,
//                    rectangleBorderColor: Colors.boneColor,
//                    rectangleBorderThickness: 3,
//                    rectangleCornerRadius: 16,
//                    mainEyeColor: Colors.boneColor,
//                    sectorColor: Colors.blackish,
//                    pupilColor: Colors.boneColor,
//                    eyeHeight: 180,
//                    paddingSize: 20,
//                    delayBetweenChangingStates: 0.015
//                )
//                .simultaneousGesture(
//                    TapGesture().onEnded {
//                        cameraView.capturePhoto() // Call the capture function
//                    }
//                )
//            }
//            .offset(y: 20)
//        }
//    }
//    
//    private func createBackEys(index: Int) -> some View {
//        let offset = eyeOffsets[index]
//        
//        return SingleBlinkingEyeView(
//            mainEyeColor: Colors.boneColor,
//            sectorColor: Colors.blackish,
//            pupilColor: Colors.boneColor,
//            delayBetweenChangingStates: 0.015,
//            isBlinking: $isBlinkingStates[index]
//        )
//        .aspectRatio(0.5, contentMode: .fit)
//        .frame(height: 200)
//        .rotationEffect(Angle(degrees: offset.rotation))
//        .offset(x: offset.x - 105, y: offset.y)
//        .onTapGesture {
//            isBlinkingStates[index] = true
//        }
//    }
//}
//
//
//#Preview {
//    CameraTesting2()
//}
