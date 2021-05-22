//
//  Mavsdk.swift
//  Mavsdk-SwiftUI-Example
//
//  Created by Douglas on 13/05/21.
//

import Foundation
import Mavsdk
import MavsdkServer

class Mavsdk: ObservableObject {
    static let sharedInstance = Mavsdk(cloudSimIP: "3.236.54.184")
    
    var drone: Drone
    var mavsdkServer = MavsdkServer()

    private init(cloudSimIP: String) {
        let systemAddress = true ? "udp://:14540" : "tcp://\(cloudSimIP):5790"
        let port = mavsdkServer.run(systemAddress: systemAddress) // DWS: use it for cloud sim connection
        drone = Drone(port: Int32(port))
    }
}
