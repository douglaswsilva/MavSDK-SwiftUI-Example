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
            Action(text: "Format Storage", action: formatStorage),
            Action(text: "Start Video Streaming", action: startVideoStreaming),
            Action(text: "Stop Video Streaming", action: stopVideoStreaming)
        ]
    }
    
    init() {}
    
    func setPhotoMode() {
        drone.camera.setMode(mode: .photo)
            .subscribe {
                self.messageViewModel.message = "Set to Photo Mode"
            } onError: { (error) in
                self.messageViewModel.message = "Error Setting Photo Mode"
            }
            .disposed(by: disposeBag)
    }
    
    func setVideoMode() {
        drone.camera.setMode(mode: .video)
            .subscribe {
                self.messageViewModel.message = "Set to Video Mode"
            } onError: { (error) in
                self.messageViewModel.message = "Error Setting Video Mode"
            }
            .disposed(by: disposeBag)
    }
    
    func takePhoto() {
        drone.camera.takePhoto()
            .subscribe {
                self.messageViewModel.message = "Photo Taken"
            } onError: { (error) in
                self.messageViewModel.message = "Error Taking Photo"
            }
            .disposed(by: disposeBag)
    }
    
    func starTakingPhotos() {
        drone.camera.startPhotoInterval(intervalS: 1.0)
            .subscribe {
                self.messageViewModel.message = "Start Taking Photos"
            } onError: { (error) in
                self.messageViewModel.message = "Error Starting Photo Interval"
            }
            .disposed(by: disposeBag)
    }
    
    func stopTakingPhotos() {
        drone.camera.stopPhotoInterval()
            .subscribe {
                self.messageViewModel.message = "Stop Taking Photos"
            } onError: { (error) in
                self.messageViewModel.message = "Error Stopping Photo Interval"
            }
            .disposed(by: disposeBag)
    }
    
    func startVideo() {
        drone.camera.startVideo()
            .subscribe {
                self.messageViewModel.message = "Start Video Recording"
            } onError: { (error) in
                self.messageViewModel.message = "Error Starting Video Recording"
            }
            .disposed(by: disposeBag)
    }
    
    func stopVideo() {
        drone.camera.stopVideo()
            .subscribe {
                self.messageViewModel.message = "Stop Video Recording"
            } onError: { (error) in
                self.messageViewModel.message = "Error Stopping Video Recording"
            }
            .disposed(by: disposeBag)
    }
    
    func getListOfPhotos() {
        drone.camera.listPhotos(photosRange: .all)
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
    
    func formatStorage() {
        drone.camera.formatStorage()
            .subscribe {
                self.messageViewModel.message = "Format Storage"
            } onError: { (error) in
                self.messageViewModel.message = "Error Formatting Storage"
            }
            .disposed(by: disposeBag)
    }
    
    func startVideoStreaming() {
        drone.camera.startVideoStreaming()
            .subscribe {
                self.messageViewModel.message = "Start Video Streaming"
            } onError: { (error) in
                self.messageViewModel.message = "Error Starting Video Streaming"
            }
            .disposed(by: disposeBag)
    }
    
    func stopVideoStreaming() {
        drone.camera.stopVideoStreaming()
            .subscribe {
                self.messageViewModel.message = "Stop Video Streaming"
            } onError: { (error) in
                self.messageViewModel.message = "Error Stopping Video Streaming"
            }
            .disposed(by: disposeBag)
    }
}
