//
//  MessageViewModel.swift
//  Mavsdk-SwiftUI-Example
//
//  Created by Douglas on 21/05/21.
//

import Foundation

class MessageViewModel: ObservableObject {
    static let shared = MessageViewModel()
    var timer: Timer?
    
    @Published var message = "-"
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { _ in
            self.message = "-"
        }
    }
}

