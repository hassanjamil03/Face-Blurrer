//
//  View.swift
//  Face Blurrer
//
//  Created by Hassan Jamil on 2022-02-25.
//

import Foundation
import SwiftUI
import AVFoundation

struct ContentView: View {
    @ObservedObject var Camera = CameraModel();
    
    @State var start:Bool = false
    @State var taps:Int = 0
    
    var body: some View {
        ZStack {
            if taps == 0 {
                Text("\( 7 )")
            } else if taps == 1 {
                ZStack {
                    
                    cameraPreview(camera: self.Camera)
                        .ignoresSafeArea()
                    
                    Button {
                        Camera.takePhoto()
                    } label: {
                        Circle()
                            .fill(.white)
                            .frame(width: 60.0, height: 60.0, alignment: .center)
                    }
                }
            }
        }.onTapGesture {
            self.Camera.check()
                taps += 1
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
