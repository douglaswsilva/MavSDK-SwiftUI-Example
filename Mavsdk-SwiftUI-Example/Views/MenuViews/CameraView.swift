//
//  CameraView.swift
//  Mavsdk-SwiftUI-Example
//
//  Created by Douglas on 20/05/21.
//

import SwiftUI

struct CameraView: View {
    
    var camera = CameraViewModel()
    
    var body: some View {
        List {
            ButtonContent(text: "Set Photo Mode", action: camera.setPhotoMode)
            ButtonContent(text: "Set Video Mode", action: camera.setVideoMode)
            ButtonContent(text: "Take Photo", action: camera.takePhoto)
            ButtonContent(text: "Start Taking Photos", action: camera.starTakingPhotos)
            ButtonContent(text: "Stop Taking Photos", action: camera.stopTakingPhotos)
            ButtonContent(text: "Start Video Recording", action: camera.startVideo)
            ButtonContent(text: "Stop Video Recoding", action: camera.stopVideo)
        }
        .listStyle(PlainListStyle())
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
