//
//  ContentView.swift
//  Mavsdk-SwiftUI-Example
//
//  Created by Douglas on 13/05/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var isVideo: Bool = true
    
    var body: some View {
        NavigationView {
            MenuView()
            ZStack(alignment: .topTrailing) {
                
                if isVideo {
                    MapView()
                        .ignoresSafeArea(.all)
                } else {
                    VideoView()
                        .ignoresSafeArea(.all)
                }

                PipView(isVideo: $isVideo.animation())
                    .frame(width: 204, height: 180)
                    .offset(x: -16, y: -104)
                
                VStack {
                    Spacer()
                    TelemetryDetailView()
                        .padding()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
