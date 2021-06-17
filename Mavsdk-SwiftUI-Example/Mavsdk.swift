//
//  Mavsdk.swift
//  Mavsdk-SwiftUI-Example
//
//  Created by Douglas on 13/05/21.
//

import Foundation
import Mavsdk
import MavsdkServer
import RxSwift

let MavScheduler = ConcurrentDispatchQueueScheduler(qos: .default)
let isSimulator = false

class Mavsdk: ObservableObject {
    static let sharedInstance = Mavsdk(cloudSimIP: "18.232.171.148")
    
    var drone: Drone
    var mavsdkServer = MavsdkServer()

    private init(cloudSimIP: String? = nil) {
        var systemAddress = ""
        
        if let cloudSimIP = cloudSimIP {
            systemAddress = "tcp://\(cloudSimIP):5790"
        } else {
            systemAddress = "udp://:14540"
        }
        
        let port = mavsdkServer.run(systemAddress: systemAddress)
        drone = Drone(port: Int32(port))
        _ = drone.core.setMavlinkTimeout(timeoutS: 2.0).subscribe()
    }
}
