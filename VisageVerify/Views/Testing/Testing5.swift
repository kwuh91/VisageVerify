//
//  Testing5.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 05.09.2024.
//

import SwiftUI

struct Testing5: View {
    @StateObject private var viewModel = CameraViewModel()

    var body: some View {
        VStack {
            if let image = viewModel.capturedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("No image captured")
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                viewModel.capturedImage = nil
                CameraView(viewModel: viewModel).capturePhoto()
            }
        }
    }
}

#Preview {
    Testing5()
}
