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
        List(camera.actions, id: \.text) { action in
            ButtonContent(text: action.text, action: action.action)
        }
        .listStyle(PlainListStyle())        
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
