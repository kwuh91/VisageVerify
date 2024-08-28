//
//  CameraView.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 25.08.2024.
//

import SwiftUI
import Combine
import UIKit
import AVFoundation

class CameraViewModel: ObservableObject {
    @Published var capturedImage: UIImage?
    // @Published var detectedFaces: Int = 0
}

struct CameraView: UIViewControllerRepresentable {
    @ObservedObject var viewModel: CameraViewModel
    
    let controller = ViewController()
    
    func makeUIViewController(context: Context) -> ViewController {
        controller.viewModel = viewModel
        return controller
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}

    func capturePhoto() {
        controller.capturePhoto()
    }
}
