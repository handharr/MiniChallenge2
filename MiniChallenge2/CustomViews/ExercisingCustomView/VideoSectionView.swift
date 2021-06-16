//
//  VideoSectionView.swift
//  XibTutorial
//
//  Created by Bayu Triharyanto on 08/06/21.
//

import UIKit
import AVKit
import AVFoundation


class VideoSectionView: UIView {
   
    var view:UIView!
    override init(frame: CGRect) {
        super.init(frame:frame)
        commonInit()
//        playVideo()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        commonInit()
    }
    func commonInit(){
        let viewFromXib = Bundle.main.loadNibNamed("VideoSectionView", owner: self, options: nil)! [0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        
    }
//    var layers = AVPlayerLayer()
//    func playVideo(){
//        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "crunches", ofType: "mov")!))
//        layers.player = player
//        layers.frame = self.bounds
//        layers.videoGravity = .resizeAspectFill
//        self.layer.addSublayer(layers)
//
//        player.actionAtItemEnd = .none
//        NotificationCenter.default.addObserver(self, selector: #selector(rewindVideo(notification:)), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
//
//        player.play()
//    }
//
//    @objc func rewindVideo(notification: Notification){
//        layers.player?.seek(to: .zero)
//    }

}
