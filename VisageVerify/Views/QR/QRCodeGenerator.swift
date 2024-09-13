//
//  GRGenerator.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 12.09.2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeGenerator {
    private let context = CIContext()
    private let filter  = CIFilter.qrCodeGenerator()
    
    func generateQRCode(from string: String, size: CGFloat = 300) -> UIImage? {
        // let combinedString = string.joined(separator: ",")
        // let base64String = combinedString.data(using: .utf8)?.base64EncodedString() ?? ""
        
        // let _ = debugPrint("setting \(base64String) as qr")
        
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            // scale the qr code image
            let scaleX = size / outputImage.extent.size.width
            let scaleY = size / outputImage.extent.size.height
            let scaledImage = outputImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
            
            // color the qr code image
            if let colorFilter = CIFilter(name: "CIFalseColor") {
                colorFilter.setValue(scaledImage, forKey: kCIInputImageKey)
                colorFilter.setValue(CIColor(color: UIColor(Colors.blackish)),  forKey: "inputColor0")
                colorFilter.setValue(CIColor(color: UIColor(Colors.boneColor)), forKey: "inputColor1")
                
                if let coloredImage = colorFilter.outputImage,
                   let cgimg = context.createCGImage(coloredImage, from: coloredImage.extent) {
                    return UIImage(cgImage: cgimg)
                }
            }
        }
        
        return nil
    }
}
