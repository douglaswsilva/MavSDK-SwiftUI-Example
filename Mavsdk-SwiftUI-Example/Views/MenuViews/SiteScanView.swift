//
//  SiteScanView.swift
//  Mavsdk-SwiftUI-Example
//
//  Created by Douglas on 20/05/21.
//

import SwiftUI

struct SiteScanView: View {
    let siteScan = SiteScanViewModel()
    
    var body: some View {
        List {
            ButtonContent(text: "Subscribe to All Observers", action: siteScan.subscribeToAllSiteScan)
            ButtonContent(text: "Run Preflight Checklist", action: siteScan.preflightCheckListQueue)
        }
        .listStyle(PlainListStyle())
    }
}

struct SiteScanView_Previews: PreviewProvider {
    static var previews: some View {
        SiteScanView()
    }
}
