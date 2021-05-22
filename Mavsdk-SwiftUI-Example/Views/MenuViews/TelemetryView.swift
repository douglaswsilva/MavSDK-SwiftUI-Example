//
//  TelemetryView.swift
//  Mavsdk-SwiftUI-Example
//
//  Created by Douglas on 14/05/21.
//

import SwiftUI


struct TelemetryView: View {
    @ObservedObject var telemetry = TelemetryViewModel()
    
    var body: some View {
        List {
            HStack {
                Text("Flight Mode")
                Spacer()
                Text("\(telemetry.flightMode)")
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .font(.system(size: 14, weight: .medium, design: .default))
        .listStyle(PlainListStyle())
    }
}

struct TelemetryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TelemetryDetailView()
    }
}
