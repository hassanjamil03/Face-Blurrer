//
//  ContentView.swift
//  Face Blurrer
//
//  Created by Hassan Jamil on 2022-01-01.
//

// great sources: https://www.raywenderlich.com/26244793-building-a-camera-app-with-swiftui-and-combine, https://medium.com/onfido-tech/building-a-simple-lane-detection-ios-app-using-opencv-4f70d8a6e6bc

import SwiftUI
import AVFoundation

// gives a user the preview of a camera
struct cameraPreview : UIViewRepresentable {
    @State var camera : CameraModel
    
    func makeUIView(context: Context) -> some UIView {
        let view : UIView = UIView(frame: UIScreen.main.bounds)
        
        // sets up preview
        camera.preview.videoGravity = .resizeAspectFill
        camera.preview.frame = UIScreen.main.bounds
        camera.preview.session = camera.captureSession
        
        // adds preview to view and returns it
        view.layer.addSublayer(camera.preview)
        
        // starts running captureSession after eveything setup
        camera.captureSession.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
