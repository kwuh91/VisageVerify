//
//  Testing3.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 10.08.2024.
//

import SwiftUI

// Define the different eye states
enum EyeState {
    case state1
    case state2
    case state2p2
    case state3
    case state3p2
    case state4
    case state4p2
    case state5
    case state5p2
    case state6
    case state6p2
    case state7
}

// Main view with blinking animation
struct BlinkingEyeView: View {
    let mainEyeColor: Color
    let sectorColor : Color
    let pupilColor  : Color
    
    var delayBetweenChangingStates: CGFloat = 0.025
    var intervalForRandomTimeBetweenBlinking: ClosedRange<CGFloat> = 1...20
    
    @State private var eyeState: EyeState = .state1
    @State private var timer: Timer?
    
    var body: some View {
        Group {
            switch eyeState {
            case .state1:
                OpenEye(mainEyeColor: mainEyeColor,
                        sectorColor:  sectorColor ,
                        pupilColor:   pupilColor  )
            case .state2:
                BlinkingEyeAnimationState2(mainEyeColor: mainEyeColor,
                                           sectorColor:  sectorColor ,
                                           pupilColor:   pupilColor  )
            case .state2p2:
                BlinkingEyeAnimationState2(mainEyeColor: mainEyeColor,
                                           sectorColor:  sectorColor ,
                                           pupilColor:   pupilColor  )
            case .state3:
                BlinkingEyeAnimationState3(mainEyeColor: mainEyeColor,
                                           sectorColor:  sectorColor ,
                                           pupilColor:   pupilColor  )
            case .state3p2:
                BlinkingEyeAnimationState3(mainEyeColor: mainEyeColor,
                                           sectorColor:  sectorColor ,
                                           pupilColor:   pupilColor  )
            case .state4:
                BlinkingEyeAnimationState4(mainEyeColor: mainEyeColor,
                                           sectorColor:  sectorColor ,
                                           pupilColor:   pupilColor  )
            case .state4p2:
                BlinkingEyeAnimationState4(mainEyeColor: mainEyeColor,
                                           sectorColor:  sectorColor ,
                                           pupilColor:   pupilColor  )
            case .state5:
                BlinkingEyeAnimationState5(mainEyeColor: mainEyeColor,
                                           sectorColor:  sectorColor ,
                                           pupilColor:   pupilColor  )
            case .state5p2:
                BlinkingEyeAnimationState5(mainEyeColor: mainEyeColor,
                                           sectorColor:  sectorColor ,
                                           pupilColor:   pupilColor  )
            case .state6:
                BlinkingEyeAnimationState6(mainEyeColor: mainEyeColor,
                                           sectorColor:  sectorColor ,
                                           pupilColor:   pupilColor  )
            case .state6p2:
                BlinkingEyeAnimationState6(mainEyeColor: mainEyeColor,
                                           sectorColor:  sectorColor ,
                                           pupilColor:   pupilColor  )
            case .state7:
                ClosedEye(mainEyeColor: .black)
            }
        }
        .onAppear() {
            scheduleNextBlink()
        }
        .onDisappear() {
            stopBlinkingAnimation()
        }
    }
    
    func startBlinkingAnimation() {
        let blinkingSequence: [EyeState] = [
            .state2,   .state3,   .state4,   .state5,   .state6,   .state7,
            .state6p2, .state5p2, .state4p2, .state3p2, .state2p2, .state1
        ]
        var delay = 0.0
        for state in blinkingSequence {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                eyeState = state
            }
            delay += delayBetweenChangingStates
        }
        scheduleNextBlink()
    }
    
    func scheduleNextBlink() {
        let randomInterval = CGFloat.random(in: intervalForRandomTimeBetweenBlinking)
        timer = Timer.scheduledTimer(withTimeInterval: randomInterval,
                                     repeats: false) { _ in
            startBlinkingAnimation()
        }
    }
    
    func stopBlinkingAnimation() {
        timer?.invalidate()
        timer = nil
    }
}

struct Eye: Identifiable {
    let id      = UUID()
    let position: CGPoint
    let size:     CGFloat
    let anchor:   UnitPoint
    var scale:    CGFloat = 0
}

struct MultipleBlinkingEyes: View {
    let quantity: Int
    
    let mainEyeColor: Color
    let sectorColor : Color
    let pupilColor  : Color
    
    var delayBetweenChangingStates: CGFloat = 0.025
    var intervalForRandomTimeBetweenBlinking: ClosedRange<CGFloat> = 1...20
    var intervalForRandomSize: ClosedRange<CGFloat> = 50...300
    var intervalForRandomDelayBeforeAppearing: ClosedRange<CGFloat> = 0...0.5
    var randomizeAnchor: Bool = true
    var animation: Animation? = .spring
    
    // private let screenWidth  = UIScreen.main.bounds.width
    // private let screenHeight = UIScreen.main.bounds.height
    
    @State private var eyes:   [Eye] = []
    @State private var action: Bool  = false
    @State private var showingAlert = false
    @State private var readyToNavigate = false
    // @State private var readyToNavigate: Bool = false
    
    // @State private var resetView = false
    
    @State private var alertMessage: String = ""
    
    @StateObject private var initialScreenViewSignInButtonTapState = SignInButtonTapState()
    // is equivalent to:
    // @StateObject private var initialScreenViewSignInButtonTapState: SignInButtonTapState = .init()
    
    @StateObject private var faceRecognition: FaceRecognition = .init(ip: "91.107.123.50")
    
    @StateObject private var registrationFormData = RegistrationFormData()
    
    // @ObservedObject private var registrationFormModel: RegistrationFormModel = .init()
    @StateObject private var cameraViewModel2: CameraViewModel = .init()
    @State private var initializeCamera = false
    
    var body: some View {
       // NavigationStack {
            let cameraView2 = CameraView2(viewModel: cameraViewModel2)
            
            GeometryReader { geometry in
                ZStack {
                    InitialScreen(signInButtonTapState: initialScreenViewSignInButtonTapState,                           registrationFormData: registrationFormData)
                    
                    // initialize camera
                    if initializeCamera {
                        cameraView2
                            .opacity(0)
                        let _ = debugPrint("Initialized camera")
                        
                            // work with photo
                            if let takenPhoto = cameraViewModel2.capturedImage {
                                
                               // if cameraView2.getCaptureStatus() {
                                let _ = debugPrint("photo taken")
                                
                                // let _ = debugPrint("original image height: \(takenPhoto.size.height), width: \(takenPhoto.size.width)")
                                
                                let resizedImage: UIImage = FaceRecognition.resizeImage(image:      takenPhoto,
                                                                                        targetSize: CGSizeMake(959.0, 1200.0))
                                
                                // let _ = debugPrint("new image height: \(resizedImage.size.height), width: \(resizedImage.size.width)")
                                
                                let _ = faceRecognition.callScript(script: "recognition", image: resizedImage)
                                
//                                // reset camera view
//                                let _ = initializeCamera = false
                                
                                // reset captured photo
                                let _ = cameraViewModel2.capturedImage = nil
                                
                            } else {
                                let _ = debugPrint("couldn't take photo")
                            }
                     //   }
                    }

                    
                    generateEyes()
                }
                
                .onAppear {
                    eyes = (0..<quantity).map { _ in
                        Eye(
                            position: CGPoint(
                                x: CGFloat.random(in: 0...geometry.size.width),
                                y: CGFloat.random(in: 0...geometry.size.height + geometry.safeAreaInsets.top)
                            ),
                            
                            size: CGFloat.random(in: intervalForRandomSize),
                            
                            anchor: UnitPoint(
                                x: CGFloat.random(in: 0...1),
                                y: CGFloat.random(in: 0...1))
                        )
                    }
                }
                
                .alert(alertMessage, isPresented: $showingAlert) {
                    Button("Got it!", role: .cancel) {
                        // showingAlert.toggle()
                        
                        // reset sign in button
                        initialScreenViewSignInButtonTapState.isButtonTapped.toggle()
                        
                        // reset status code
                        faceRecognition.postResultStatusCode = -1
                        

                        
                        // reset capture
                        cameraView2.resetCapture()
                    }
                }
                
                .onChange(of: initialScreenViewSignInButtonTapState.isButtonTapped) {
                    // initialize camera
                    initializeCamera.toggle()

                    let dispatchGroup = DispatchGroup()

                    // action 1
                    action.toggle()
                    for index in eyes.indices {
                        let delay = CGFloat.random(in: intervalForRandomDelayBeforeAppearing)
                        dispatchGroup.enter()
                        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                            withAnimation(animation) {
                                eyes[index].scale = action ? 1 : 0
                            }
                            dispatchGroup.leave()
                        }
                    }

                    dispatchGroup.notify(queue: .main) {
                        // action 2
                        if readyToNavigate {
                            initialScreenViewSignInButtonTapState.readyToNavigate = true
                        }

                        // Reset the state if needed
                        // initialScreenViewSignInButtonTapState.isButtonTapped = false
                    }
                }

                
                .onChange(of: faceRecognition.postResultStatusCode) {
                    switch faceRecognition.postResultStatusCode {
                        case 404:
                            debugPrint("Current showingAlert state: \(showingAlert)")
                            alertMessage = "You are not registered"
                            showingAlert.toggle()
                        case 405, 406:
                            alertMessage = "an error has occurred"
                            showingAlert.toggle()
                        case 500:
                            alertMessage = "internal server error"
                            showingAlert.toggle()
                        case 200:
                        registrationFormData.registrationFormModel.populateWithUserData(userID: faceRecognition.postResult) {
                            // resetView.toggle()
                            
                            readyToNavigate = true
                            
                            // reset sign in button
                            initialScreenViewSignInButtonTapState.isButtonTapped.toggle()
                            
                            // reset status code
                            faceRecognition.postResultStatusCode = -1
                            
                            // reset capture
                            cameraView2.resetCapture()
                            
                            // initialScreenViewSignInButtonTapState.readyToNavigate = true
                            
//                            alertMessage = "we good, \(registrationFormData.registrationFormModel.user.username) (\(registrationFormData.registrationFormModel.user.realName))"
//                            showingAlert.toggle()
                        }
                        case -1:
                            debugPrint("in -1")
                            alertMessage = ""
                        default:
                            alertMessage = "something went wrong"
                            showingAlert.toggle()
                    }
                }
                
//                .navigationDestination(isPresented: $readyToNavigate) {
//                   // FloatingFireflies(quantity: 5)
//                    // Testing2(registrationFormModel: registrationFormModel)
//                    ProfileScreen(registrationFormModel: registrationFormModel)
//               }
            }
       // }
        // .scrollContentBackground(.hidden)
    }
        
    @ViewBuilder func generateEyes() -> some View {
        GeometryReader { geometry in
            ForEach(eyes.indices, id: \.self) { index in
                let eye = eyes[index]
                BlinkingEyeView(
                    mainEyeColor: mainEyeColor,
                    sectorColor:  sectorColor,
                    pupilColor:   pupilColor,
                    delayBetweenChangingStates: delayBetweenChangingStates,
                    intervalForRandomTimeBetweenBlinking: intervalForRandomTimeBetweenBlinking
                )
                .aspectRatio(0.5, contentMode: .fit)
                .frame(height: eye.size)
                .position(eye.position)
                .scaleEffect(
                    eye.scale,
                    anchor: randomizeAnchor ? eye.anchor :
                        UnitPoint(
                    x: 1 / geometry.size.width * eye.position.x,
                    y: 1 / (geometry.size.height + geometry.safeAreaInsets.top) * eye.position.y)
                        )
            }
        }
    }
}

    
#Preview {
    MultipleBlinkingEyes(quantity:     70,
                         mainEyeColor: Colors.blackish,
                         sectorColor:  Colors.boneColor,
                         pupilColor:   Colors.blackish,
                         delayBetweenChangingStates: 0.025,
                         intervalForRandomTimeBetweenBlinking: 1...30,
                         intervalForRandomSize: 50...300,
                         intervalForRandomDelayBeforeAppearing: 0...0.25,
                         randomizeAnchor: false,
                         animation: .spring(duration: 0.5, bounce: 0.5))
}
