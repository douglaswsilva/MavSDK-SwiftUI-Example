//
//  SiteScanViewModel.swift
//  Mavsdk-SwiftUI-Example
//
//  Created by Douglas on 20/05/21.
//

import RxSwift
import Mavsdk

final class SiteScanViewModel: ObservableObject {
    lazy var drone = Mavsdk.sharedInstance.drone
    
    var siteScan: SiteScanMavsdk?
    let disposeBag = DisposeBag()
    
    init() {}
    
    func subscribeToAllSiteScan() {
        siteScan = SiteScanMavsdk()
    }
    
    func preflightCheckListQueue() {
        let routine = Completable.concat([cameraCheck().do(onSubscribe: { print("PreFli: -- Camera Check -- ") }),
                                          missionCheck(SurveyMission.mission).do(onSubscribe: { print("PreFli: -- Mission Check -- ") }),
                                          swipeToTakeOff().do(onSubscribe: { print("PreFli: -- Swipe Takeoff -- ") })])
        
        routine
            .subscribeOn(SerialDispatchQueueScheduler(qos: .userInitiated))
            .do(onError: { (error) in
                print("PreFli: Error \(error)")
            }, onCompleted: {
                print("PreFli: Mission Started!")
            }, onSubscribed: {
                print("PreFli: Checks!")
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func aircraftCheck() {
        // TODO
    }
    
    func cameraCheck() -> Completable {
        let first =  Completable.empty() // Anotacao drone.camera.stopPhotoInterval().do(onSubscribed: { print("PreFli: stopPhotoInterval") })
        let second = drone.camera.takePhoto().do(onSubscribed: { print("PreFli: takePhoto") })
        let third = drone.camera.listPhotos(photosRange: .sinceConnection).asCompletable().do(onSubscribed: { print("PreFli: listPhotos") })
        
        return Completable.concat([first, second, third])
    }
    
    func batteryCheck() {
        // TODO
    }
    
    func missionCheck(_ missionPlan: Mission.MissionPlan) -> Completable {
        let first = Completable.empty() // Anotacao continueWithoutLinkCheck()
        let second = setRTLAfterMissionCheck()
        let third = uploadMissionCheck(missionPlan)
        let fourth = setRTLAltitudeCheck()
        
        return Completable.concat([first, second, third, fourth])
    }
    
    func swipeToTakeOff() -> Completable {
        let first = drone.mission.setCurrentMissionItem(index: Int32(0)).do(onSubscribed: { print("PreFli: setCurrentMissionItem") })
        let second = drone.action.arm().do(onSubscribed: { print("PreFli: arm") })
        let third = drone.mission.startMission().do(onSubscribed: { print("PreFli: startMission") })
        
        return Completable.concat([first, second, third])
    }
}

// MARK: - Mission Check
extension SiteScanViewModel {
    func continueWithoutLinkCheck() -> Completable {
        let first = drone.param.setParamFloat(name: "COM_RC_LOSS_MAN", value: 1.0)
        let second = drone.param.setParamInt(name: "NAV_DLL_ACT", value: 0)
        let third = drone.param.setParamInt(name: "NAV_RCL_ACT", value: 0)
        
        return Completable.concat([first, second, third])
    }
    
    func setRTLAfterMissionCheck() -> Completable {
        return drone.mission.setReturnToLaunchAfterMission(enable: true).do(onSubscribed: { print("PreFli: setReturnToLaunchAfterMission") })
    }
    
    func uploadMissionCheck(_ missionPlan: Mission.MissionPlan) -> Completable {
        let first = drone.mission.cancelMissionDownload().do(onSubscribed: { print("PreFli: cancelMissionDownload") })
        let second = drone.mission.cancelMissionUpload().do(onSubscribed: { print("PreFli: cancelMissionUpload") })
        let third = drone.mission.uploadMission(missionPlan: missionPlan).do(onSubscribed: { print("PreFli: uploadMission") })
        
        return Completable.concat([first, second, third])
    }
    
    func setRTLAltitudeCheck() -> Completable {
        return drone.action.setReturnToLaunchAltitude(relativeAltitudeM: 60.0).do(onSubscribed: { print("PreFli: setReturnToLaunchAltitude") })
    }
}
