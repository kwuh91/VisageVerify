//
//  CameraTesting3.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 27.08.2024.
//

import SwiftUI
import FirebaseStorage

struct RegistrationCameraScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var cameraViewModel: CameraViewModel = .init()
    @StateObject private var faceRecognition: FaceRecognition = .init(ip: "91.107.123.50")
    
    @ObservedObject var registrationFormModel: RegistrationFormModel
    
    @State private var chaosMode: Bool = false
    @State private var viewID = UUID()
    @State private var instructionsText: String = "take a photo"
    @State private var readyToNavigate: Bool = false
    
    let fireflies = FloatingFireflies(quantity: 100)
    
    var body: some View {
        NavigationStack{
            let cameraView = CameraView(viewModel: cameraViewModel)
            
            GeometryReader { geometry in
                ZStack {
                    // background color
                    (chaosMode ? Colors.boneColor : Colors.blackish)
                        .ignoresSafeArea()
                    
                    // chaos mode
                    fireflies
                        .mask(
                            Image(systemName: chaosMode ? "theatermasks.fill" : "theatermasks")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .font(Font.title.weight(.thin))
                                .frame(width:  geometry.size.width * 0.1,
                                       height: geometry.size.width * 0.1)
                        )
                        .position(x: geometry.size.width * 0.9,
                                  y: geometry.safeAreaInsets.top * 0.5)
                        .shadow(color: .black, radius: 5)
                        .animation(.spring, value: chaosMode)
                        .onTapGesture {
                            chaosMode.toggle()
                            // cameraViewModel.capturedImage = nil
                            viewID = UUID()
                        }
                        // .opacity(0) // fucking threads
                    
                    VStack {
                        // camera
                        //                    Image("ben")
                        //                        .resizable()
                        //                        .aspectRatio(contentMode: .fill)
                        //                        .frame(width:  geometry.size.width * 0.85,
                        //                               height: geometry.size.width * 0.85)
                        //                        .clipShape(Circle())
                        //                        .shadow(color: .black, radius: 10)
                        
                        if let takenPhoto = cameraViewModel.capturedImage {
                            
                            if chaosMode {
                                RandomPhotoView(inputImage: takenPhoto)
                                    .frame(width:  geometry.size.width * 0.85,
                                           height: geometry.size.width * 0.85)
                                    .rotationEffect(Angle(degrees: 90))
                                    .scaleEffect(x: -1, y: 1)
                                    .shadow(color: chaosMode ? Colors.blackish : .black, radius: 10)
                            } else {
                                Image(uiImage: takenPhoto)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width:  geometry.size.width * 0.85,
                                           height: geometry.size.width * 0.85)
                                    .clipShape(Circle())
                                    .scaleEffect(x: -1, y: 1)
                                    .shadow(color: chaosMode ? Colors.blackish : .black, radius: 10)
                                
    //                            EnhancedPhotoView(inputImage: takenPhoto)
    //                                .frame(width:  geometry.size.width * 0.85,
    //                                       height: geometry.size.width * 0.85)
    //                                .rotationEffect(Angle(degrees: 90))
                            }
                            
                        } else {
                            cameraView
                                .id(viewID)
                                .frame(width:  geometry.size.width * 0.85,
                                       height: geometry.size.width * 0.85)
                                .clipShape(Circle())
                                .shadow(color: chaosMode ? Colors.blackish : .black, radius: 10)
                                // .opacity(0)
                        }
                        
                        // Text
                        ZStack {
                            PrettyText(text:     instructionsText,
                                       fontName: "ArsenalSC-Regular",
                                       color:    chaosMode ? Colors.blackish : Colors.boneColor,
                                       fontSize: 30)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        .offset(y: geometry.size.height / 30)
                        .padding(40)
                        .frame(height: 100)
                        
                        // Access the face count directly without triggering re-renders
                        //                    Text("Detected Faces: \(cameraViewModel.detectedFaces)")
                        //                        .foregroundColor(Colors.boneColor)
                        //                        .font(.headline)
                        //                        .padding()
                        
                        Spacer(minLength: geometry.size.height / 20)
                        
                        // buttons
                        HStack {
                            
                            // Back button
                            Button(action: {
                                if cameraViewModel.capturedImage != nil {
                                    cameraViewModel.capturedImage = nil
                                    debugPrint("cleared photo after 'back' button was pressed")
                                }
                                
                                DispatchQueue.main.async {
                                    self.dismiss() // Dismiss the view when tapped
                                }
                            }) {
                                fireflies
                                    .mask(
                                        Image(systemName: "arrowtriangle.left")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: geometry.size.height / 15)
                                            .font(Font.title.weight(.thin))
                                    )
                            }
                            
                            // take photo button
                            TakePhotoButton(rectangleColor: Colors.blackish, rectangleHeight: 80, rectangleBorderColor: Colors.boneColor, rectangleBorderThickness: 3, rectangleCornerRadius: 16, mainEyeColor: Colors.boneColor, sectorColor: Colors.blackish, pupilColor: Colors.boneColor, eyeHeight: 180, paddingSize: 1, delayBetweenChangingStates: 0.015)
                                .padding(30)
                                .simultaneousGesture(
                                    TapGesture().onEnded {
                                        if cameraViewModel.capturedImage == nil {
                                            cameraView.capturePhoto() // Call the capture function
                                        } else {
                                            cameraViewModel.capturedImage = nil
                                        }
                                    }
                                )
                            
                            // next button
                            Button(action: {
                                if cameraViewModel.capturedImage == nil {
                                    instructionsText = "to proceed, you have to take a photo"
                                    viewID = UUID()
                                } else {
                                    print("'next' button tapped")
                                    
                                    let image: UIImage = cameraViewModel.capturedImage!
                                    
                                    debugPrint("original image height: \(image.size.height), width: \(image.size.width)")
                                    
                                    let resizedImage: UIImage = FaceRecognition.resizeImage(image:      image,
                                                                                            targetSize: CGSizeMake(959.0, 1200.0))
                                    
                                    // upload image to storage
//                                    if let compressedImageData = resizedImage.jpegData(compressionQuality: 0.5) {
//                                        uploadCompressedImageToFirebase(imageData: compressedImageData,
//                                                                        imageName: "\(registrationFormModel.user.username)-biometry-image") { imageURL in
//                                            if let url = imageURL {
//                                                registrationFormModel.user.imageURL = url
//                                                debugPrint("image url uploaded successfully!")
//                                            } else {
//                                                debugPrint("failed to upload iamge url to db")
//                                            }
//                                        }
//                                    } else {
//                                        debugPrint("failed to compress image")
//                                    }
                                    
                                    debugPrint("new image height: \(resizedImage.size.height), width: \(resizedImage.size.width)")
                                    
                                    faceRecognition.callScript(script: "registration", image: resizedImage)
                                }
                            }) {
                                fireflies
                                    .mask(
                                        Image(systemName: "arrowtriangle.right")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: geometry.size.height / 15)
                                            .font(Font.title.weight(.thin))
                                    )
                            }
                             .navigationDestination(isPresented: $readyToNavigate) {
                                // FloatingFireflies(quantity: 5)
                                 // Testing2(registrationFormModel: registrationFormModel)
                                 ProfileScreen(registrationFormModel: registrationFormModel)
                            }
                        }
                        .shadow(color: .black, radius: 5)
                        .offset(y: geometry.size.height / 15)
                    }
                    .offset(y: geometry.size.height / 20)
                    
                }
                .animation(.spring, value: chaosMode)
                .navigationBarBackButtonHidden(true) // Hide the default back button
                
                .onChange(of: faceRecognition.postResultStatusCode) {
                    switch faceRecognition.postResultStatusCode {
                        case 401:
                            instructionsText = "there can only be one face present on the screen"
                        case 402:
                            instructionsText = "face was not found"
                        case 403:
                            instructionsText = "your face is already in the database"
                        case 405, 406:
                            instructionsText = "error"
                        case 200:
                            print("writing to database: \(faceRecognition.postResult)")
                            registrationFormModel.user.biometry = faceRecognition.postResult
                        
                            // upload image to storage and register user
                            let image: UIImage = cameraViewModel.capturedImage!
                            
                            if let compressedImageData = image.jpegData(compressionQuality: 1) {
                                uploadImageToFirebase(imageData: compressedImageData,
                                                      imageName: "\(registrationFormModel.user.username)-biometry-image") { imageURL in
                                    if let url = imageURL {
                                        registrationFormModel.user.imageURL = url
                                        debugPrint("image url uploaded successfully! \(registrationFormModel.user.imageURL)")
                                        
                                        registrationFormModel.registerUser()
                                        debugPrint("registered user!")
                                        
                                        readyToNavigate.toggle()
                                    } else {
                                        debugPrint("failed to upload image url to db")
                                    }
                                }
                            } else {
                                debugPrint("failed to compress image")
                            }
                        default:
                            instructionsText = "something went wrong"
                    }
                }
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    viewID = UUID()
                    debugPrint("RegistrationCameraScreen screen refreshed")
                }
            }
        }
    }

    func uploadImageToFirebase(imageData: Data, imageName: String, completion: @escaping (String?) -> Void) {
        // Reference to Firebase Storage
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        // Create a reference to the file you want to upload
        let imageRef = storageRef.child("biometry-images/\(imageName).jpg")
        
        // Upload the compressed image data
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        imageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                print("Error uploading image: \(error)")
                completion(nil)
                return
            }
            
            // Get download URL for the uploaded image
            imageRef.downloadURL { (url, error) in
                if let error = error {
                    print("Error getting download URL: \(error)")
                    completion(nil)
                } else if let downloadURL = url?.absoluteString {
                    completion(downloadURL)  // Return the download URL
                }
            }
        }
    }
}
    
//#Preview {
//    @ObservedObject var registrationFormModel: RegistrationFormModel = .init()
//    
//    return RegistrationCameraScreen(registrationFormModel: registrationFormModel)
//}
