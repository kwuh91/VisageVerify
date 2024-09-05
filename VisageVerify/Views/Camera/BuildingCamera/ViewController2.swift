//
//  ViewController2.swift
//  VisageVerify
//
//  Created by Nikita Ochkin on 05.09.2024.
//

import UIKit
import AVFoundation
import Vision

class ViewController2: UIViewController {

  // MARK: - Variables
  
  private var drawings: [CAShapeLayer] = []
  
  private let videoDataOutput = AVCaptureVideoDataOutput()
  private let captureSession  = AVCaptureSession()
  private let photoOutput     = AVCapturePhotoOutput()
    
  var capturedPhoto: Bool = false
    
  // Using `lazy` keyword because the `captureSession` needs to be loaded before we can use the preview layer.
  private lazy var previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
  
  // Store the captured photo in this variable
  var viewModel: CameraViewModel?
    
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    addCameraInput()
    showCameraFeed()
    getCameraFrames()
      
    captureSession.addOutput(photoOutput)
      
    //DispatchQueue.global(qos: .background).async {
        captureSession.startRunning()
    //}
  }
  
  // The account for when the container's `view` changes.
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    previewLayer.frame = view.frame
  }
  
  // MARK: - Helper Functions
  
  private func addCameraInput() {
    
    guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInTrueDepthCamera, .builtInDualCamera, .builtInWideAngleCamera], mediaType: .video, position: .front).devices.first else {
      fatalError("No camera detected. Please use a real camera and not a simulator.")
    }

      do {
          let cameraInput = try AVCaptureDeviceInput(device: device)
          captureSession.addInput(cameraInput)
      } catch {
          print("Error adding camera input: \(error)")
      }
  }
  
  private func showCameraFeed() {
    previewLayer.videoGravity = .resizeAspectFill
    view.layer.addSublayer(previewLayer)
    previewLayer.frame = view.frame
  }
  
    private func getCameraFrames() {
        videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString): NSNumber(value: kCVPixelFormatType_32BGRA)] as [String: Any]
        
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        // Offload processing of frames to another thread
        videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"))
        
        captureSession.addOutput(videoDataOutput)
        
        guard let connection = videoDataOutput.connection(with: .video) else {
            return
        }
        
        let rotationAngle: CGFloat = 90 // Equivalent to .portrait orientation
        
        // Check if the connection supports the specific video rotation angle
        if connection.isVideoRotationAngleSupported(rotationAngle) {
            connection.videoRotationAngle = rotationAngle
        }
    }

  private func detectFace(image: CVPixelBuffer) {
    let faceDetectionRequest = VNDetectFaceLandmarksRequest { vnRequest, error in
      DispatchQueue.main.async {
        if let results = vnRequest.results as? [VNFaceObservation], results.count > 0 {
          // print("✅ Detected \(results.count) faces!")
            if !self.capturedPhoto {
                self.capturePhoto() // take photo if face detected
                self.capturedPhoto = true
                debugPrint("Took photo")
            }
          self.handleFaceDetectionResults(observedFaces: results)
        } else {
          // print("❌ No face was detected")
          // если ты читаешь это в 3 ночи, то бегом спать!
          self.clearDrawings()
        }
      }
    }
    
    let imageResultHandler = VNImageRequestHandler(cvPixelBuffer: image, orientation: .leftMirrored, options: [:])
    try? imageResultHandler.perform([faceDetectionRequest])
  }
  
  private func handleFaceDetectionResults(observedFaces: [VNFaceObservation]) {
    clearDrawings()
      
    // Create the boxes
    let facesBoundingBoxes: [CAShapeLayer] = observedFaces.map({ (observedFace: VNFaceObservation) -> CAShapeLayer in
      
      let faceBoundingBoxOnScreen = previewLayer.layerRectConverted(fromMetadataOutputRect: observedFace.boundingBox)
      let faceBoundingBoxPath = CGPath(rect: faceBoundingBoxOnScreen, transform: nil)
      let faceBoundingBoxShape = CAShapeLayer()
      
      // Set properties of the box shape
      faceBoundingBoxShape.path = faceBoundingBoxPath
      faceBoundingBoxShape.fillColor = UIColor.clear.cgColor
      faceBoundingBoxShape.strokeColor = UIColor.green.cgColor
      
      return faceBoundingBoxShape
    })
    
    // Add boxes to the view layer and the array
    facesBoundingBoxes.forEach { faceBoundingBox in
      view.layer.addSublayer(faceBoundingBox)
      drawings = facesBoundingBoxes
    }
  }
  
  private func clearDrawings() {
    drawings.forEach({ drawing in drawing.removeFromSuperlayer() })
  }
    
    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
  
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate

extension ViewController2: AVCaptureVideoDataOutputSampleBufferDelegate {
  
  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    
    guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
      debugPrint("Unable to get image from the sample buffer")
      return
    }
    
    detectFace(image: frame)
  }
  
}

extension ViewController2: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error)")
            return
        }
        
        guard let imageData = photo.fileDataRepresentation(), let capturedImage = UIImage(data: imageData) else {
            print("Failed to get image data from photo output.")
            return
        }
        
        DispatchQueue.main.async {
            self.viewModel?.capturedImage = capturedImage
        }
    }
}
