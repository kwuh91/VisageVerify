//
//  ProfilePictureView.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 04.09.2024.
//

import SwiftUI
import PhotosUI

struct ProfilePictureView: View {
    @State private var profileImage: Image? = Image(systemName: "person.crop.circle.fill") // Replace with your default image
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    var width:    CGFloat
    var height:   CGFloat
    // var position: CGPoint
    
    var body: some View {
        VStack {
            ZStack {
                // background for profile image
                Circle()
                    .frame(width: width * 0.95, height: height * 0.95)
                    .foregroundStyle(Colors.blackish)
                
                // profile image
                profileImage?
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .foregroundStyle(Colors.boneColor)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Colors.boneColor, lineWidth: 4))
                // .shadow(radius: 10)
                    .onTapGesture {
                        requestPhotoLibraryAccess()
                    }
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        profileImage = Image(uiImage: inputImage)
    }

    func requestPhotoLibraryAccess() {
        let status = PHPhotoLibrary.authorizationStatus()

        switch status {
        case .notDetermined:
            // The user hasn't granted or denied permission yet, so request access
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized || newStatus == .limited {
                    showingImagePicker = true
                }
            }
        case .authorized, .limited:
            // Permission already granted
            showingImagePicker = true
        case .denied, .restricted:
            // Permission denied or restricted
            // Optionally, show an alert to the user explaining why the app needs access
            print("Access denied or restricted")
        @unknown default:
            break
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    @Environment(\.presentationMode) var presentationMode

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
}

#Preview {
    ZStack {
        Colors.boneColor
            .ignoresSafeArea()
        
        ProfilePictureView(width: 200, height: 200)
    }
}
