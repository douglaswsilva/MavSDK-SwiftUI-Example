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
        drone.camera.startPhotoInterval(intervalS: 2.0)
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
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
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
}
