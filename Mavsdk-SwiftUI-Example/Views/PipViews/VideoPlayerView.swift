//
//  VideoPlayerView.swift
//  Mavsdk-SwiftUI-Example
//
//  Created by Douglas on 21/05/21.
//

import SwiftUI
import AVKit
import Mavsdk
import MavsdkServer
import RxSwift

// Convert UIView into SwiftUI.
struct VideoPlayerView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return PlayerUIView(frame: frame)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Nothing to do here for now.
    }
}

class PlayerUIView: UIView {
    var rtspView: RTSPView!
    
    let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
       
        fetchVideoStream()
    }
    
    func fetchVideoStream() {
        Mavsdk.sharedInstance.drone.camera.videoStreamInfo
            .take(1)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { value in
                print("+DC+ videoStreamInfo \(value)")
                if self.rtspView == nil {
                    self.addVideoFeed(value.settings.uri)
                }
            }, onError: { error in
                print("+DC+ camera videoStreamInfo error: \(String(describing: error))")
            })
            .disposed(by: disposeBag)
    }
    
    func addVideoFeed(_ videoPath: String) {
        let newPath = videoPath.replacingOccurrences(of: "rtspt", with: "rtsp")
        rtspView = RTSPView(frame: self.frame)
        
        self.addSubview(rtspView)
        rtspView.translatesAutoresizingMaskIntoConstraints = false
        rtspView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        rtspView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        rtspView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        rtspView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true

        self.rtspView.startPlaying(videoPath: newPath, usesTcp: isSimulator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        rtspView?.frame = bounds
    }
}

