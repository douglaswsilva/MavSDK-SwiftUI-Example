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
    static let sharedInstance = Mavsdk(cloudSimIP: "3.227.211.180")
    
    var drone: Drone
    var mavsdkServer = MavsdkServer()

    private init(cloudSimIP: String) {
        let systemAddress = isSimulator ? "tcp://\(cloudSimIP):5790" : "udp://:14540"
        let port = mavsdkServer.run(systemAddress: systemAddress) // DWS: use it for cloud sim connection
        drone = Drone(port: Int32(port))
    }
}
