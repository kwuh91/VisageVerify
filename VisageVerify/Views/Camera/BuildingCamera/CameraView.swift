//
//  CameraView.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 25.08.2024.
//

import SwiftUI

class CameraViewModel: ObservableObject {
    @Published var capturedImage: UIImage?
}

struct CameraView: UIViewControllerRepresentable {
    @ObservedObject var viewModel: CameraViewModel
    let controller = ViewController()
    
    func makeUIViewController(context: Context) -> ViewController {
        controller.viewModel = viewModel
        return controller
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // No need to do anything here for now
    }

    func capturePhoto() {
        controller.capturePhoto()
    }
}

