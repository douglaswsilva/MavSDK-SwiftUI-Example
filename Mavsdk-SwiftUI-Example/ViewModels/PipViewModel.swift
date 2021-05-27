//
//  PipViewModel.swift
//  Mavsdk-SwiftUI-Example
//
//  Created by Douglas on 14/05/21.
//

import Foundation
import RxSwift

final class PipViewModel: ObservableObject {
    @Published private(set) var isConnected = false
    
    lazy var drone = Mavsdk.sharedInstance.drone
    let disposeBag = DisposeBag()
    
    init() {
        observeDroneConnectionState()
    }
    
    func observeDroneConnectionState() {
        drone.core.connectionState
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (state) in
                self.isConnected = state.isConnected
            })
            .disposed(by: disposeBag)
    }
}
