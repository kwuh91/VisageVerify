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
        // initial profile image logic
        .onAppear {
            let storageRef = Storage.storage().reference()
            let imageRef = storageRef.child("profile-pictures/\(registrationFormModel.user.username)-profilePicture.png")

            imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
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

        if let uploadData = self.inputImage?.pngData() {
            imagesRef.child("\(registrationFormModel.user.username)-profilePicture.png").putData(uploadData, metadata: nil) { (metadata, error) in
              guard let _ = metadata else {
                  debugPrint("an error1 has ocurred: \(String(describing: error?.localizedDescription))")
                return
              }
              // Metadata contains file metadata such as size, content-type, and download URL.
            debugPrint("Saved image to firebase storage")
            }
        }
        
//        // get the image URL
//        imagesRef.child("\(registrationFormModel.user.username)-profilePicture.png").downloadURL { (url, error) in
//          guard let downloadURL = url else {
//              debugPrint("an error2 has ocurred: \(String(describing: error?.localizedDescription))")
//            return
//          }
//            
//        // Now you can save the downloadURL to Firestore
//        registrationFormModel.updateUserProfileImage(imageURL: downloadURL)
//            
//        }


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

//#Preview {
//    ZStack {
//        Colors.boneColor
//            .ignoresSafeArea()
//        
//        ProfilePictureView(width: 200, height: 200)
//    }
//}
