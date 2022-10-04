//
//  Model.swift
//  Face Blurrer
//
//  Created by Hassan Jamil on 2022-02-25.
//

import Foundation
import SwiftUI
import AVFoundation


// class represetning the camera
class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    // begins a session, ie beings capturing data from device
    @Published var captureSession = AVCaptureSession()
    
    // where photo output will be put when photo is taken
    @Published var photoOutput = AVCapturePhotoOutput()
    
    // where camera preview will be published
    @Published var preview = AVCaptureVideoPreviewLayer()
    
    // where the jpeg photo is stored from photoOutput
    @Published var photoJPEG : Data = Data()
    
    // specifies the settings photo is captured with
    let photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
    
    
    // function asks for camera permission
    func check() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
        case .authorized: // The user has previously granted access to the camera.
            self.setUp()
            
        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.setUp()
                }
            }
            
        default: // for all other cases just return
            return
        }
    }
    
    
    // configures inputs and outputs to captuerSession
    func setUp() {
        
        do {
            // about to add inputs and outputs to capture session
            captureSession.beginConfiguration()
            
                // specifies the video device from which data is captured from
                guard let videoDevice = AVCaptureDevice.default(.builtInDualWideCamera, for: .video, position: .back) else {
                    print("No back camera device found, please make sure to run SimpleLaneDetection in an iOS device and not a simulator")
                    return
                }
                
                // the input to the videoDevice
                let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
                
                // checks if input/output can be added to captureSession, if so then adds it
                if captureSession.canAddInput(videoDeviceInput) {
                    captureSession.addInput(videoDeviceInput)
                }
                if captureSession.canAddOutput(photoOutput) {
                    captureSession.addOutput(photoOutput)
                }
            
            // done adding inputs and outputs to session
            captureSession.commitConfiguration()
        }
        catch {
            print(error.localizedDescription)
            return
        }
    }
    
    
    // takes a photo
    func takePhoto() {
        photoOutput.capturePhoto(with: photoSettings, delegate: self)
        self.captureSession.stopRunning()
    }
    
    // ran when a photo is taken, retrieves photo in JPEG, and puts the jpeg into photoJPEG @state variable
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil {
            // getting the jpeg photo and putting into variable
            photoJPEG = photo.fileDataRepresentation()!
            
            // turns photo from CGImage -> UIImage
            var photoCGImage:CGImage = photo.cgImageRepresentation()!
            var photoUIImage:UIImage = UIImage(cgImage: photoCGImage)
            
            
            return
        }
    }
}
