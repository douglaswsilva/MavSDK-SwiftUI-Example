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

struct VideoPlayerView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return PlayerUIView(frame: frame)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

class PlayerUIView: UIView {
    var rtspView: RTSPView!
    
    let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        
        addVideoFeed()
    }
    
    func addVideoFeed() {

        rtspView = RTSPView(frame: self.frame)
        
        self.addSubview(rtspView)
        rtspView.translatesAutoresizingMaskIntoConstraints = false
        rtspView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        rtspView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        rtspView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        rtspView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true

        rtspView.startPlaying(videoPath: "rtsp://192.168.43.1:58554/stream", usesTcp: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        rtspView.frame = bounds
    }
}

