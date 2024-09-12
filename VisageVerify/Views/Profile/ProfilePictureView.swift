//
//  ProfilePictureView.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 04.09.2024.
//

import SwiftUI
import PhotosUI
import FirebaseStorage

struct ProfilePictureView: View {
    @State private var profileImage: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @ObservedObject var registrationFormModel: RegistrationFormModel
    
    var width:    CGFloat
    var height:   CGFloat
    
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
                    .onTapGesture {
                        requestPhotoLibraryAccess()
                    }
            }
        }
        // initial profile image logic
        .onAppear {
            let storageRef = Storage.storage().reference()
            
            let _ = debugPrint("searching for \(registrationFormModel.user.username) profile pic")
            
            let imageRef = storageRef.child("profile-pictures/\(registrationFormModel.user.username)-profilePicture.jpg")

            imageRef.getData(maxSize: 20 * 1024 * 1024) { data, error in
                if let error = error {
                    print("Error downloading image: \(error)")
                    self.profileImage = Image(systemName: "person.crop.circle.fill") // set the default profile image
                } else if let data = data, let uiImage = UIImage(data: data) {
                    print("Setting image from the database")
                    self.profileImage = Image(uiImage: uiImage) // set profile image from the database
                }
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
    }

    func loadImage() {
        guard let inputImage = self.inputImage else { return }
        profileImage = Image(uiImage: inputImage)
        
        // load profile picture to firebase storage
        let storageRef = Storage.storage().reference()
        let imagesRef = storageRef.child("profile-pictures")

        if let uploadData = self.inputImage?.jpegData(compressionQuality: 0.5) {
            // Check if the image size exceeds the maximum size
            let maxSize = 20 * 1024 * 1024 // 20 MB
            if uploadData.count > maxSize {
                // Handle the error, e.g., show an alert to the user
                print("Image size exceeds the maximum allowed size of \(maxSize) bytes")
                return
            }
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            imagesRef.child("\(registrationFormModel.user.username)-profilePicture.jpg").putData(uploadData, metadata: metadata) { (metadata, error) in
              guard let _ = metadata else {
                  debugPrint("an error1 has ocurred: \(String(describing: error?.localizedDescription))")
                return
              }
              // Metadata contains file metadata such as size, content-type, and download URL.
            debugPrint("Saved image to firebase storage")
            }
        }
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
                // Check if the image size exceeds the maximum size
                let maxSize = 20 * 1024 * 1024 // 20 MB
                if let imageData = uiImage.jpegData(compressionQuality: 0.5), imageData.count > maxSize {
                    // Image size exceeds the maximum allowed size, show an alert and don't update the image
                    let alert = UIAlertController(title: "Image Too Large", message: "The selected image (\(imageData.count / 1024 / 1024) MB) exceeds the maximum allowed size of 20 MB.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        picker.dismiss(animated: true, completion: nil)
                    }))
                    picker.present(alert, animated: true, completion: nil)
                } else {
                    // Image size is within the allowed limit, update the image
                    parent.image = uiImage
                    parent.presentationMode.wrappedValue.dismiss()
                }
            }
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

//#Preview {
//    ZStack {
//        Colors.boneColor
//            .ignoresSafeArea()
//        
//        ProfilePictureView(width: 200, height: 200)
//    }
//}
