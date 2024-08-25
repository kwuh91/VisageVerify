//
//  CameraTesting.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 24.08.2024.
//

import SwiftUI

struct CameraTesting: View {
    
    @StateObject private var viewModel = CameraViewModel()
    // @State private var capturedImage: UIImage?
    
    var body: some View {
        let cameraView = CameraView(viewModel: viewModel)
        
        VStack {
            cameraView
                .frame(width: 300, height: 400)
                .border(Color.gray, width: 2)
            
            Button(action: {
                cameraView.capturePhoto() // Call the capture function
            }) {
                Text("Capture Photo")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            
            // Display the captured image if available
            if let image = cameraView.viewModel.capturedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .border(Color.gray, width: 2)
                    .padding(.top, 20)
                
                let _ = print("displayed it")
            }
        }
    }

}

#Preview {
    CameraTesting()
}
