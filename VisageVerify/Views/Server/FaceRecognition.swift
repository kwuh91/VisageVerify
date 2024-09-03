//
//  FaceRecognition.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 29.08.2024.
//

import SwiftUI

class FaceRecognition: ObservableObject {
    @Published var postResult: String = ""
    
    var ip: String
    
    init(ip: String) {
        self.ip = ip
    }
    
    func registrationScript(url: String, image: UIImage) {
        debugPrint("Entered script func")
        
        guard let url = URL(string: url),
              let imageData = image.jpegData(compressionQuality: 1.0) else {
            print("Invalid URL or failed to convert image to data")
            return
        }

        debugPrint("image prepared for the script: \(imageData), of type: \(type(of: imageData))")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"ben.jpeg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        let task = URLSession.shared.uploadTask(with: request, from: body) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.postResult = "Error: \(error.localizedDescription)"
                }
                debugPrint("1")
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    self.postResult = "No data or response."
                }
                debugPrint("2")
                return
            }

            if response.statusCode == 200 {
                DispatchQueue.main.async {
                    debugPrint("Got post result: \(String(decoding: data, as: UTF8.self))")
                    self.postResult = String(decoding: data, as: UTF8.self)
                }
                debugPrint("3")
            } else {
                DispatchQueue.main.async {
                    self.postResult = "Error: \(response.statusCode)"
                    debugPrint(self.postResult)
                }
                debugPrint("4")
            }
        }
        
        debugPrint("5")
        
        task.resume()
    }
    
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}



extension Data {
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}
