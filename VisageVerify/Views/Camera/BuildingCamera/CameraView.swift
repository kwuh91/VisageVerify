//
//  CameraView.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 25.08.2024.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // No need to update anything here for now
    }
}
