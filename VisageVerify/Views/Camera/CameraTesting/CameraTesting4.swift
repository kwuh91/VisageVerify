//
//  CameraTesting4.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 28.08.2024.
//

//import SwiftUI
//
//struct CameraTesting4: View {
//    @StateObject private var cameraViewModel: CameraViewModel = .init()
//
//    var body: some View {
//        let cameraView = CameraView(viewModel: cameraViewModel)
//
//        VStack {
//            // Camera preview or captured image
//            if let takenPhoto = cameraViewModel.capturedImage {
//                Image(uiImage: takenPhoto)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 250, height: 250)
//            } else {
//                cameraView
//                    .frame(width: 250, height: 250)
//            }
//
//            // Display the count of detected faces
//            Text("Faces detected: \(cameraViewModel.detectedFaceCount)")
//                .padding()
//
//            // Take photo button
//            Button("Take Photo") {
//                cameraView.capturePhoto()
//            }
//        }
//    }
//}
//
//#Preview {
//    CameraTesting4()
//}
