//
//  CameraViewModel.swift
//  Mavsdk-SwiftUI-Example
//
//  Created by Douglas on 20/05/21.
//

import Foundation
import RxSwift

final class CameraViewModel: ObservableObject {
    lazy var drone = Mavsdk.sharedInstance.drone
    let messageViewModel = MessageViewModel.shared
    let disposeBag = DisposeBag()
    
    var actions: [Action] {
        return [
            Action(text: "Set Photo Mode", action: setPhotoMode),
            Action(text: "Set Video Mode", action:setVideoMode),
            Action(text: "Take Photo", action: takePhoto),
            Action(text: "Start Taking Photos", action: starTakingPhotos),
            Action(text: "Stop Taking Photos", action: stopTakingPhotos),
            Action(text: "Start Video Recording", action: startVideo),
            Action(text: "Stop Video Recoding", action: stopVideo),
            Action(text: "List of Photos", action: getListOfPhotos),
            Action(text: "Start Video Streaming", action: startVideoStreaming),
            Action(text: "Stop Video Streaming", action: stopVideoStreaming),
            Action(text: "Subscribe Camera Mode", action: mode),
            Action(text: "Subscribe Camera Status", action: status)
        ]
    }
    
    
    init() {}
    
    func setPhotoMode() {
        drone.camera.setMode(mode: .photo)
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe {
                self.messageViewModel.message = "Set to Photo Mode"
            } onError: { (error) in
                self.messageViewModel.message = "Error Setting Photo Mode"
            }
            .disposed(by: disposeBag)
    }
    
    func setVideoMode() {
        drone.camera.setMode(mode: .video)
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe {
                self.messageViewModel.message = "Set to Video Mode"
            } onError: { (error) in
                self.messageViewModel.message = "Error Setting Video Mode"
            }
            .disposed(by: disposeBag)
    }
    
    func takePhoto() {
        drone.camera.takePhoto()
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe {
                self.messageViewModel.message = "Photo Taken"
            } onError: { (error) in
                self.messageViewModel.message = "Error Taking Photo"
            }
            .disposed(by: disposeBag)
    }
    
    func starTakingPhotos() {
        drone.camera.startPhotoInterval(intervalS: 1.0)
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe {
                self.messageViewModel.message = "Start Taking Photos"
            } onError: { (error) in
                self.messageViewModel.message = "Error Starting Photo Interval"
            }
            .disposed(by: disposeBag)
    }
    
    func stopTakingPhotos() {
        drone.camera.stopPhotoInterval()
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe {
                self.messageViewModel.message = "Stop Taking Photos"
            } onError: { (error) in
                self.messageViewModel.message = "Error Stopping Photo Interval"
            }
            .disposed(by: disposeBag)
    }
    
    func startVideo() {
        drone.camera.startVideo()
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe {
                self.messageViewModel.message = "Start Video Recording"
            } onError: { (error) in
                self.messageViewModel.message = "Error Starting Video Recording"
            }
            .disposed(by: disposeBag)
    }
    
    func stopVideo() {
        drone.camera.stopVideo()
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe {
                self.messageViewModel.message = "Stop Video Recording"
            } onError: { (error) in
                self.messageViewModel.message = "Error Stopping Video Recording"
            }
            .disposed(by: disposeBag)
    }
    
    func getListOfPhotos() {
        drone.camera.listPhotos(photosRange: .all)
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .do(onSuccess: { (captureInfo) in
                self.messageViewModel.message = "List Count \(captureInfo.count)"
            }, onError: { (error) in
                self.messageViewModel.message = "Error Getting List"
            },  onSubscribe: {
                self.messageViewModel.message = "Getting List of Photos"
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func startVideoStreaming() {
        drone.camera.startVideoStreaming()
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe {
                self.messageViewModel.message = "Start Video Streaming"
            } onError: { (error) in
                self.messageViewModel.message = "Error Starting Video Streaming"
            }
            .disposed(by: disposeBag)
    }
    
    func stopVideoStreaming() {
        drone.camera.stopVideoStreaming()
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe {
                self.messageViewModel.message = "Stop Video Streaming"
            } onError: { (error) in
                self.messageViewModel.message = "Error Stopping Video Streaming"
            }
            .disposed(by: disposeBag)
    }
    
    func subscribeCameraMode() {
        drone.camera.stopVideoStreaming()
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe {
                self.messageViewModel.message = "Stop Video Streaming"
            } onError: { (error) in
                self.messageViewModel.message = "Error Stopping Video Streaming"
            }
            .disposed(by: disposeBag)
    }
    
    func mode() {
        drone.camera.mode
            .distinctUntilChanged()
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { value in
                print("+DC+ camera mode: \(value)")
            }, onError: { error in
                print("+DC+ camera mode error: \(String(describing: error))")
            })
            .disposed(by: disposeBag)
    }
    
    func status() {
        drone.camera.status
            .distinctUntilChanged()
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { value in
                print("+DC+ camera status: \(value)")
            }, onError: { error in
                print("+DC+ camera status error: \(String(describing: error))")
            })
            .disposed(by: disposeBag)
    }
}
