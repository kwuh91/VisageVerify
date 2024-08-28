//
//  CoreImageFilterView.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 28.08.2024.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import Vision

struct RandomPhotoView: View {
    let inputImage: UIImage
    @State private var filteredImage: UIImage?

    let context = CIContext()
    
    var body: some View {
        VStack {
            if let filteredImage = filteredImage {
                Image(uiImage: filteredImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
            } else {
                Text("Processing...")
                    .padding()
            }
        }
        .onAppear {
            applyEnhancements()
        }
    }

    private func applyEnhancements() {
        guard let ciImage = CIImage(image: inputImage) else { return }

        // Apply the enhancement filters with a "gloomy" effect
        let enhancedImage = applyGloomyEnhancements(to: ciImage)
        
        if let outputImage = enhancedImage, let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            self.filteredImage = UIImage(cgImage: cgImage)
        }
    }
    
    private func applyGloomyEnhancements(to image: CIImage) -> CIImage? {
        // Randomize parameters for various filters
        let randomBrightness = Float.random(in: -0.2...0.2)
        let randomContrast = Float.random(in: 0.8...1.2)
        let randomSaturation = Float.random(in: 0.5...1.5)
        let randomSharpness = Float.random(in: 0.3...1.0)
        let randomVignetteIntensity = Float.random(in: 0.1...0.8)
        let randomVignetteRadius = Float.random(in: 0.6...2.0)
        let randomHueAngle = Float.random(in: -Float.pi...Float.pi)

        // Apply filters in a random sequence
        let enhancedImage = image
            .applyingFilter("CIColorControls", parameters: [
                kCIInputBrightnessKey: randomBrightness,
                kCIInputContrastKey: randomContrast,
                kCIInputSaturationKey: randomSaturation
            ])
            .applyingFilter("CISharpenLuminance", parameters: [
                kCIInputSharpnessKey: randomSharpness
            ])
            .applyingFilter("CIVignette", parameters: [
                kCIInputIntensityKey: randomVignetteIntensity,
                kCIInputRadiusKey: randomVignetteRadius
            ])
            .applyingFilter("CIHueAdjust", parameters: [
                kCIInputAngleKey: randomHueAngle
            ])
            .applyingFilter("CINoiseReduction", parameters: [
                kCIInputSharpnessKey: randomSharpness
            ])
            .cropped(to: image.extent)

        return enhancedImage
    }
}
    
struct EnhancedPhotoView: View {
    let inputImage: UIImage
    @State private var filteredImage: UIImage?

    let context = CIContext()
    
    var body: some View {
        VStack {
            if let filteredImage = filteredImage {
                Image(uiImage: filteredImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .shadow(color: Colors.boneColor, radius: 10)
            } else {
                Text("Processing...")
                    .padding()
            }
        }
        .onAppear {
            applyEnhancements()
        }
    }

    private func applyEnhancements() {
        let ciImage = CIImage(image: inputImage)
        
        // Apply a series of filters to improve photo quality
        let filteredImage = ciImage?
            .applyingFilter("CIColorControls", parameters: [kCIInputContrastKey: 1.1, kCIInputBrightnessKey: -0.005])
            .applyingFilter("CISharpenLuminance", parameters: [kCIInputSharpnessKey: 0.5])
            .applyingFilter("CIVignette", parameters: [kCIInputIntensityKey: 0.2, kCIInputRadiusKey: 0.8])
            .cropped(to: ciImage!.extent)

        if let outputImage = filteredImage, let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            self.filteredImage = UIImage(cgImage: cgImage)
        }
    }
}

//#Preview {
//    CoreImageFilterView()
//}
