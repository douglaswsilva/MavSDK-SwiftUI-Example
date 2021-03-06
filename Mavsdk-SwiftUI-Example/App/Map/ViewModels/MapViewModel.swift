//
//  MapViewModel.swift
//  Mavsdk-SwiftUI-Example
//
//  Created by Douglas on 14/05/21.
//

import Foundation
import RxSwift

final class MapViewModel: ObservableObject {
    @Published private(set) var droneLocation = Location(latitude: 37.4135427, longitude: -121.99655, angle: 0.0)
    
    lazy var drone = Mavsdk.sharedInstance.drone
    let disposeBag = DisposeBag()
    
    init() {
        observeDroneLocation()
    }
    
    func observeDroneLocation() {
        Observable.combineLatest(drone.telemetry.attitudeEuler, drone.telemetry.position)
            .observeOn(MainScheduler.instance)
            .distinctUntilChanged({ (angle, position) in
                Location(latitude: position.latitudeDeg, longitude: position.longitudeDeg, angle: Double(angle.yawDeg))
            })
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { (angle, position) in
                self.droneLocation = Location(latitude: position.latitudeDeg, longitude: position.longitudeDeg, angle: Double(angle.yawDeg))
            }, onError: { (error) in
                print("Error in observeDroneLocation: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
