//
//  VideoView.swift
//  Mavsdk-SwiftUI-Example
//
//  Created by Douglas on 14/05/21.
//

import SwiftUI

struct VideoView: View {
    var body: some View {
        if isSimulator {
            Rectangle().foregroundColor(.gray)
        } else {
            VideoPlayerView() // Anotacao
        }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
