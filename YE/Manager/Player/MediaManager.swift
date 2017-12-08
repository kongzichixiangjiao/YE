//
//  MediaManager.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/1.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

/*
使用方法：
MediaManager.sharedInstance.playEmbeddedVideo(url:"http://qiniu.puxinasset.com/099f507aed7c5799d5ff40386a1a9615.mp4".ga_url!, embeddedContentView: playerBackView)
 */

/*
import UIKit
import EZPlayer
class MediaManager {
     var player: EZPlayer?
     var mediaItem: MediaItem?
     var embeddedContentView: UIView?

    static let sharedInstance = MediaManager()
    private init(){

        NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidPlayToEnd(_:)), name: NSNotification.Name.EZPlayerPlaybackDidFinish, object: nil)

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func playEmbeddedVideo(url: URL, embeddedContentView contentView: UIView? = nil, userinfo: [AnyHashable : Any]? = nil) {
        var mediaItem = MediaItem()
        mediaItem.url = url
        self.playEmbeddedVideo(mediaItem: mediaItem, embeddedContentView: contentView, userinfo: userinfo )

    }

    func playEmbeddedVideo(mediaItem: MediaItem, embeddedContentView contentView: UIView? = nil , userinfo: [AnyHashable : Any]? = nil ) {
        //stop
        self.releasePlayer()
        
        if let skinView = userinfo?["skin"] as? UIView{
         self.player =  EZPlayer(controlView: skinView)
        }else{
          self.player = EZPlayer()
        }
        
        if let autoPlay = userinfo?["autoPlay"] as? Bool{
            self.player!.autoPlay = autoPlay
        }

        if let fullScreenMode = userinfo?["fullScreenMode"] as? EZPlayerFullScreenMode{
            self.player!.fullScreenMode = fullScreenMode
        }
        
        self.player!.backButtonBlock = { fromDisplayMode in
            if fromDisplayMode == .embedded {
                self.releasePlayer()
            }else if fromDisplayMode == .fullscreen {
                if self.embeddedContentView == nil && self.player!.lastDisplayMode != .float{
                    self.releasePlayer()
                }
                
            }else if fromDisplayMode == .float {
                self.releasePlayer()
            }
            
        }
        
        self.embeddedContentView = contentView
        
        self.player!.playWithURL(mediaItem.url! , embeddedContentView: self.embeddedContentView)
    }

    func releasePlayer(){
            self.player?.stop()
            self.player?.view.removeFromSuperview()
        
        self.player = nil
        self.embeddedContentView = nil
        self.mediaItem = nil

    }
    
    @objc  func playerDidPlayToEnd(_ notifiaction: Notification) {
       //结束播放关闭播放器
       //self.releasePlayer()

    }


}
*/
