//
//  MenuView.swift
//  Mavsdk-SwiftUI-Example
//
//  Created by Douglas on 13/05/21.
//

import SwiftUI

struct MenuView: View {
    @State private var selectedColorIndex = 0
    
    var body: some View {
        VStack {
            Picker("Item", selection: $selectedColorIndex, content: {
                Image(systemName: "antenna.radiowaves.left.and.right").tag(0)
                Image(systemName: "play").tag(1)
                Image(systemName: "point.topleft.down.curvedto.point.bottomright.up").tag(2)
                Image(systemName: "camera").tag(3)
                Image(systemName: "chevron.up").tag(4)
            })
            .pickerStyle(SegmentedPickerStyle())
            
            switch selectedColorIndex {
            case 0:
                TelemetryView()
                    .navigationBarTitle("Telemetry")
            case 1:
                ActionList()
                    .navigationBarTitle("Actions")
            case 2:
                MissionView()
                    .navigationBarTitle("Mission")
            case 3:
                CameraView()
                    .navigationBarTitle("Camera")
            default:
                SiteScanView()
                    .navigationBarTitle("Site Scan")
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
