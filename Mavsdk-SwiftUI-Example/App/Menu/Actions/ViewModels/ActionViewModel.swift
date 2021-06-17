//
//  ActionViewModel.swift
//  Mavsdk-SwiftUI-Example
//
//  Created by Douglas on 14/05/21.
//

import Foundation
import RxSwift

final class ActionViewModel: ObservableObject {
    lazy var drone = Mavsdk.sharedInstance.drone
    let messageViewModel = MessageViewModel.shared
    let disposeBag = DisposeBag()
    
    var actions: [Action] {
        return [
            Action(text: "Arm", action: armAction),
            Action(text: "Disarm", action: disarmAction),
            Action(text: "TakeOff", action: takeOffAction),
            Action(text: "Land", action: landAction),
            Action(text: "RTL", action: rtlAction),
            Action(text: "Set RTL Altitude", action: setRTLAltitude)
        ]
    }
    
    init() {}
    
    func armAction() {
        drone.action.arm()
            .subscribe {
                self.messageViewModel.message = "Armed"
            } onError: { (error) in
                self.messageViewModel.message = "Error Arming"
            }
            .disposed(by: disposeBag)
    }
    
    func disarmAction() {
        drone.action.disarm()
            .subscribe {
                self.messageViewModel.message = "Disarmed"
            } onError: { (error) in
                self.messageViewModel.message = "Error Disarming"
            }
            .disposed(by: disposeBag)
    }
    
    func takeOffAction() {
        drone.action.takeoff()
            .subscribe {
                self.messageViewModel.message = "Taking Off"
            } onError: { (error) in
                self.messageViewModel.message = "Error Taking Off"
            }
            .disposed(by: disposeBag)
    }
    
    func landAction() {
        drone.action.land()
            .subscribe {
                self.messageViewModel.message = "Landing"
            } onError: { (error) in
                self.messageViewModel.message = "Error Landing"
            }
            .disposed(by: disposeBag)
    }
    
    func rtlAction() {
        drone.action.returnToLaunch()
            .subscribe {
                self.messageViewModel.message = "RTL"
            } onError: { (error) in
                self.messageViewModel.message = "Error RTL"
            }
            .disposed(by: disposeBag)
    }
    
    func setRTLAltitude() {
        drone.action.setReturnToLaunchAltitude(relativeAltitudeM: 40)
            .subscribe(onCompleted: {
                self.messageViewModel.message = "Set RTL Altitude"
            }, onError: { (error) in
                self.messageViewModel.message = "Error Setting RTL Altitude"
            })
            .disposed(by: disposeBag)
    }
}
