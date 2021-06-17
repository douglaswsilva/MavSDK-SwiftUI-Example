//
//  TelemetryViewModel.swift
//  Mavsdk-SwiftUI-Example
//
//  Created by Douglas on 14/05/21.
//

import Foundation
import RxSwift
import Mavsdk

final class TelemetryViewModel: ObservableObject {
    @Published private(set) var flightMode = "-"
    
    lazy var drone = Mavsdk.sharedInstance.drone
    let disposeBag = DisposeBag()
    
    init() {
        observeDroneTelemetry()
    }
    
    func observeDroneTelemetry() {
        drone.telemetry.flightMode
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (mode) in
                self.flightMode = mode.toString()
            })
            .disposed(by: disposeBag)
    }
}

extension Telemetry.FlightMode {
    func toString() -> String {
        var modeString = ""
        switch self {
        case .unknown:
            modeString = "Unknown"
        case .ready:
            modeString = "Ready"
        case .takeoff:
            modeString = "Take Off"
        case .hold:
            modeString = "Hold"
        case .mission:
            modeString = "Mission"
        case .returnToLaunch:
            modeString = "RTL"
        case .land:
            modeString = "Land"
        case .offboard:
            modeString = "Offboard"
        case .followMe:
            modeString = "Follow Me"
        case .UNRECOGNIZED(_):
            modeString = "Unrecognized"
        case .manual:
            modeString = "Manual"
        case .altctl:
            modeString = "Altitude Control"
        case .posctl:
            modeString = "Position Control"
        case .acro:
            modeString = "Acro"
        case .stabilized:
            modeString = "Stabilized"
        case .rattitude:
            modeString = "Rattitude"
        }
        
        return modeString
    }
}
