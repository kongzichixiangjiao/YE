//
//  YYPlayer.swift
//  YYPlayer
//
//  Created by 侯佳男 on 2018/5/2.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation
import MediaPlayer

open class YYPlayer: NSObject {
    
    // 监听四种keyPath
    private let kPath_status = "status"
    private let kPath_loadedTimeRanges = "loadedTimeRanges"
    private let kPath_playbackBufferEmpty = "playbackBufferEmpty"
    private let kPath_playbackLikelyToKeepUp = "playbackLikelyToKeepUp"
    
    // 单例
    public static let share: YYPlayer = YYPlayer()
    
    // 实时播放的闭包
    public typealias DisplayLinkHandler = (_ currentTime: CMTime, _ catchTime: CMTime?, _ state: YYPlayerState) -> ()
    // 播放内容的单例
    public typealias PlayerInfo = (_ totalTime: CMTime, _ state: AVPlayerItemStatus) -> ()
    // 播放完成的单例
    public typealias PlayFinished = () -> ()
    
    public var displayLinkHandler: DisplayLinkHandler!
    public var playerInfo: PlayerInfo!
    public var playFinished: PlayFinished!
    
    var displayLink: CADisplayLink! // 实时刷新progress
    var cacheTime: CMTime? // 缓存时间
    var playerInfoState: AVPlayerItemStatus = .unknown
    
    override init() {
        super.init()
    }
    
    // url
    public var url: URL? {
        willSet {
            self.asset = AVAsset(url: newValue!)
            self.playerItem = AVPlayerItem(asset: self.asset!)
            player.replaceCurrentItem(with: playerItem)
        }
        didSet {
            addObserver()
            addNotificationCenter()
        }
    }
    
    lazy var asset: AVAsset? = {
        guard let url = self.url else {
            return AVAsset()
        }
        let asset = AVAsset(url: self.url!)
        return asset
    }()
    
    public lazy var playerLayer: AVPlayerLayer = {
        let playerLayer = AVPlayerLayer(player: player)
        return playerLayer
    }()
    
    lazy var player: AVPlayer = {
        let player = AVPlayer(playerItem: playerItem)
        return player
    }()
    
    lazy var playerItem: AVPlayerItem = {
        let playerItem = AVPlayerItem(asset: self.asset!)
        return playerItem
    }()
    
    // MARK: 监听通知：播放结束、异常中断、进入后台、进入前天
    fileprivate func addNotificationCenter() {
        // 添加视频播放结束通知
        NotificationCenter.default.addObserver(self, selector: #selector(didPlayToEndTimeNotification), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        // 添加视频异常中断通知
        NotificationCenter.default.addObserver(self, selector: #selector(playbackStalledNotification), name: Notification.Name.AVPlayerItemPlaybackStalled, object: playerItem)
        
        // 添加程序将要进入后台通知
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterBcakgroundNotification), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
        // 添加程序已经返回前台通知
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterPlayGroundNotification), name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    // 移除通知中心
    fileprivate func removeNotificationCenter() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.AVPlayerItemPlaybackStalled, object: playerItem)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    // 播放结束
    @objc func didPlayToEndTimeNotification() {
        displayLinkHandler(playerItem.currentTime(), CMTime(), .play)
        displayLink.invalidate()
        
        playFinished()
    }
    // 播放异常
    @objc func playbackStalledNotification() {
        
    }
    // 播放进入后台
    @objc func willEnterBcakgroundNotification() {
        player.pause()
    }
    // 播放返回前台
    @objc func didEnterPlayGroundNotification() {
        // 需要手动播放
    }
    
    // MARK: 监听事件
    // 添加观察者
    fileprivate func addObserver() {
        // 观察播放状态
        playerItem.addObserver(self, forKeyPath: kPath_status, options: .new, context: nil)
        
        // 观察加载完毕的时间范围
        playerItem.addObserver(self, forKeyPath: kPath_loadedTimeRanges, options: .new, context: nil)
        
        // seekToTime后，缓冲数据为空，而且有效时间内数据无法补充，播放失败
        playerItem.addObserver(self, forKeyPath: kPath_playbackBufferEmpty, options: .new, context: nil)
        
        //seekToTime后, 可以正常播放，相当于readyToPlay，一般拖动滑竿菊花转，到了这个这个状态菊花隐藏
        playerItem.addObserver(self, forKeyPath: kPath_playbackLikelyToKeepUp, options: .new, context: nil)
    }
    
    // 移除监听
    fileprivate func removeObserve() {
        playerItem.removeObserver(self, forKeyPath: kPath_status, context: nil)
        playerItem.removeObserver(self, forKeyPath: kPath_loadedTimeRanges, context: nil)
        playerItem.removeObserver(self, forKeyPath: kPath_playbackBufferEmpty, context: nil)
        playerItem.removeObserver(self, forKeyPath: kPath_playbackLikelyToKeepUp, context: nil)
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // 创建局部的PlayerItem
        let observePlayerItem = object as? AVPlayerItem
        
        switch keyPath! {
        case kPath_status:
            if observePlayerItem?.status == .readyToPlay {
                self.playerInfo(playerItem.duration, .readyToPlay)
            } else if observePlayerItem?.status == .failed {
                print("获取播放内容出错！")
                self.playerInfo(CMTime(seconds: 0, preferredTimescale: 0), .failed)
            } else {
                print("未知错误")
                self.playerInfo(CMTime(seconds: 0, preferredTimescale: 0), .unknown)
            }
            playerInfoState = (observePlayerItem?.status)!
        case kPath_loadedTimeRanges:
            // 播放器的缓存进度
            let loadedTimeRanges = observePlayerItem?.loadedTimeRanges
            let timeRange = loadedTimeRanges?.first?.timeRangeValue  // 获取缓冲区域
            cacheTime = (timeRange?.duration)!
            guard let duration = timeRange?.duration else {
                return
            }
            if duration.seconds < Double(2) {
                player.pause()
            }
            break
        case kPath_playbackBufferEmpty:
            // 播放缓冲区空
            print("playbackBufferEmpty")
            break
        case kPath_playbackLikelyToKeepUp:
            // 由于 AVPlayer 缓存不足就会自动暂停，所以缓存充足了需要手动播放，才能继续播放
            // 判断是否有缓冲数据
            print("playbackLikelyToKeepUp")
            break
        default:
            break
        }
    }
    
    public func update(state: YYPlayerState) {
        self.state = state
    }
    
    public var state: YYPlayerState! {
        didSet {
            switch state {
            case .play:
                _play()
            case .pause:
                _pause()
            case .stop:
                _stop()
            case .finished:
                break
            case .unknow:
                _unknow()
            case .none:
                break
            case .some(_):
                break
            }
        }
    }
    
    // 出错之后点击播放调起该方法
    // 无网时候进入视频播放界面 再次播放调用 此方法
    public func againLoadPlayerItem() {
        let url = self.url
        self.url = url
    }
    
    // 播放
    private func _play() {
        if playerInfoState != .readyToPlay {
            return
        }
        player.play()
        displayLink = CADisplayLink(target: self, selector: #selector(refreshProgress))
        displayLink.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
    }
    
    // 暂停
    private func _pause() {
        player.pause()
    }
    
    // 停止
    private func _stop() {
        playerItem.seek(to: kCMTimeZero)
        update(state: .pause)
        removeObserve()
        removeNotificationCenter()
    }
    
    // 未知状态
    private func _unknow() {
        print("更改状态时候发生未知错误")
    }
    
    // 设置播放到哪个时间点
    public func seek(seconds: Double) {
        let time = CMTime(seconds: seconds, preferredTimescale: 260)
        player.seek(to: time)
    }
    
    // 实时刷新progress
    @objc private func refreshProgress() {
        displayLinkHandler(playerItem.currentTime(), CMTime(), .play)
    }
    
    // release
    public func releaseAll() {
        _stop()
    }
    
    deinit {
        print("YYPlayer deinit")
        NotificationCenter.default.removeObserver(self)
    }
}
