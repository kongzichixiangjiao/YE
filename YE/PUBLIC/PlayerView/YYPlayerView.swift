//
//  YYPlayerView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/27.
//  Copyright © 2017年 侯佳男. All rights reserved.
// 提交github
//  播放器

/**
 注：
 <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
     <plist version="1.0">
        <dict>
            <key>NSAllowsArbitraryLoads</key>
            <true/>
        </dict>
    </plist>

 // 示例:
    @IBOutlet weak var playerBackView: UIView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    func initPlayerView() {
        self.pplayerBackView.addSubview(pView)

        playerBackView.addConstraint(NSLayoutConstraint(item: pView, attribute: .left, relatedBy: .equal, toItem: playerBackView, attribute: .left, multiplier: 1, constant: 0))
        playerBackView.addConstraint(NSLayoutConstraint(item: pView, attribute: .top, relatedBy: .equal, toItem: playerBackView, attribute: .top, multiplier: 1, constant: 0))
        playerBackView.addConstraint(NSLayoutConstraint(item: pView, attribute: .bottom, relatedBy: .equal, toItem: playerBackView, attribute: .bottom, multiplier: 1, constant: 0))
        playerBackView.addConstraint(NSLayoutConstraint(item: pView, attribute: .right, relatedBy: .equal, toItem: playerBackView, attribute: .right, multiplier: 1, constant: 0))
    }
 
    lazy var pView: YYPlayerView = {
        let v = YYPlayerView.loadPlayerView()
        v.urlString = "http://qiniu.puxinasset.com/099f507aed7c5799d5ff40386a1a9615.mp4"
        v.maskImageView.image = UIImage()
        return v
    }()
*/

/*
 *  1、返回前一页
 *  2、上下渐变层
 *  3、遮罩imageView层
 *  4、播放暂停按钮
 *  5、屏幕中间播放按钮
 *  6、进度条
 *  7、播放时间显示
 *  8、大屏/小屏切换
 *  9、屏幕亮度调节
 *  10、系统声音调节
 *  11、快进/快退
 *  12、点击屏幕隐藏/展示上下渐变层
 */

import UIKit
import MediaPlayer

// MARK: 播放器状态枚举
enum YYPlayerState: Int {
    case play = 1, pause = 2, stop = 3, finished = 4, unknow = 99
}

// MARK: 播放器屏幕枚举
enum YYPlayerScreenState: Int {
    case full = 1, small = 2
}

class YYPlayerView: UIView {
    
    // 是否展示预览图
    public var isShowMaskImageView: Bool = true
    // 快进/快退时间
    public var intervalTime: Double = 4
    // 播放的url
    public var urlString: String? {
        didSet {
            guard let url = URL(string: urlString!) else {
                print("错误 urlString ❎❌❌❌❌❎")
                return
            }
            
            config(url: url)
        }
    }
    
    // 初始化YYPlayerView方法
    static func loadPlayerView() -> YYPlayerView {
        return Bundle.main.loadNibNamed("YYPlayerView", owner: self, options: nil)?.last as! YYPlayerView
    }
    
    // 设置屏幕方向时候需要的key
    private let kOrientation = "orientation"
    
    private var totalTime: Double = 0 // 总时间
    private var currentTime: Double = 0 // 当前播放时间
    private var fullState: YYPlayerScreenState = .small // 屏幕状态
    private var playerInfoState: AVPlayerItemStatus = .unknown // 播放内容状态
    private var isSliderDragging: Bool = false // 是否在拖拽
    private var isFinished: Bool = false // 是否播放结束 // 可以设置播放一次之后的特别状态
    private var isPlayed: Bool = false // 是否播放过
    
    @IBOutlet weak var topBackView: UIView! // 顶部view层
    @IBOutlet weak var screenView: UIView! // 屏幕层 承载播放界面
    @IBOutlet weak var bottomBackView: UIView! // 底部view层
    @IBOutlet weak var playAndPauseButton: YYPlayerButton! // 播放暂停按钮
    @IBOutlet weak var centerPlayButton: UIButton! // 中间播放按钮: 1、播放隐藏 2、播放完成显示
    @IBOutlet weak var currentTimeLabel: UILabel! // 当前播放时间显示
    @IBOutlet weak var totalTimeLabel: UILabel! // 总时间显示
    @IBOutlet weak var progressSlider: UISlider! // 进度条
    @IBOutlet weak var fullScreenButton: YYPlayerButton! // 全屏、小屏切换按钮
    @IBOutlet weak var maskImageView: UIImageView! // 遮罩图层
    @IBOutlet weak var topMaskView: YYPlayerGradualChangeView! // 顶部渐变图层
    @IBOutlet weak var bottomMaskView: YYPlayerGradualChangeView! // 底部渐变图层
    
    // 当前类播放状态 和YYPlayer同步
    var playerSate: YYPlayerState = .pause {
        didSet {
            switch playerSate {
            case .play:
                if isFinished {
                    YYPlayer.share.seek(seconds: 0)
                    isFinished = false
                }
                YYPlayer.share.update(state: .play)
                playAndPauseButton.playState = .play
            case .pause:
                YYPlayer.share.update(state: .pause)
                playAndPauseButton.playState = .pause
            case .stop:
                YYPlayer.share.update(state: .stop)
            case .finished:
                break
            case .unknow:
                print("更改状态时候发生未知错误")
            }
        }
    }
    
    // 返回按钮事件
    @IBAction func backAction(_ sender: UIButton) {
        if fullState == .full {
            // 退出全屏
            fullAction(fullScreenButton)
        } else {
            playerViewController?.navigationController?.popViewController(animated: true)
            releasePlayer()
        }
    }
    
    // 播放/暂停按钮事件
    @IBAction func playAndPauseAction(_ sender: UIButton) {
        updatePlayerState()
    }
    
    // 中间播放按钮事件
    @IBAction func centerPlayButtonAction(_ sender: UIButton) {
        updatePlayerState()
    }
    
    // 播放暂停按钮点击状态改变
    private func updatePlayerState() {
        if (playerInfoState != .readyToPlay) {
            print("播放错误")
            YYPlayer.share.againLoadPlayerItem()
        } else {
            if playerSate == .play {
                playerSate = .pause
                return
            }
            if playerSate == .pause {
                playerSate = .play
                if isShowMaskImageView {
                    maskImageView.isHidden = true
                }
                topAndBottomViewAnimation()
                centerPlayButton.isHidden = true
                isPlayed = true
            }
        }
    }
    
    // 进度条按下事件
    @IBAction func progressSliderTouchDownAction(_ sender: UISlider) {
        playerSate = .pause
        isSliderDragging = true
    }
    
    // 进度条按下外部结束事件
    @IBAction func progressSliderTouchOutsideAction(_ sender: UISlider) {
        progressSliderTouchEnd(sender)
    }
    
    // 进度条按下内部结束事件
    @IBAction func progressSliderTouchUpInsideAction(_ sender: UISlider) {
        progressSliderTouchEnd(sender)
    }
    
    // 按下结束事件
    private func progressSliderTouchEnd(_ sender: UISlider) {
        if playAndPauseButton.playState == .play {
            playAndPauseButton.playState = .pause
        }
        playerSate = .play
        YYPlayer.share.seek(seconds: Double(sender.value) * totalTime)
        isSliderDragging = false
        if isShowMaskImageView {
            maskImageView.isHidden = true
        }
    }
    
    /// 全屏切换事件
    /// UIResponder类别中的一个属性allowRotation：是否可以横屏
    @IBAction func fullAction(_ sender: YYPlayerButton) {
        sender.isSelected = !sender.isSelected
        let appdelegate = UIApplication.shared.delegate as! UIResponder
        let value: Int
        if fullState == .small {
            fullState = .full
            appdelegate.allowRotation = true
            value = UIInterfaceOrientation.landscapeLeft.rawValue
        } else {
            fullState = .small
            appdelegate.allowRotation = false
            value = UIInterfaceOrientation.portrait.rawValue
        }
        // 设置之后会走application代理方法(application:supportedInterfaceOrientationsForWindow:)
        UIDevice.current.setValue(value, forKey: kOrientation)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 横竖屏切换从新设置playerLayer大小， 第一次添加playerLayer也会走起
        screenView.layer.insertSublayer(YYPlayer.share.playerLayer, below: self.maskImageView.layer)
        YYPlayer.share.playerLayer.frame = bounds
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initGestureRecognizer()
    }
    
    // 添加手势
    private func initGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapScreenView(_:)))
        self.screenView.addGestureRecognizer(tap)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panScreenView(_:)))
        self.screenView.addGestureRecognizer(pan)
    }
    
    // 点击屏幕手势方法 显示/隐藏山下渐变层
    @objc func tapScreenView(_ sender: UITapGestureRecognizer) {
        topAndBottomViewAnimation()
    }
    
    // 屏幕滑动手势
    @objc func panScreenView(_ sender: UIPanGestureRecognizer) {
        guard let view = sender.view else {
            return
        }
        let location = sender.location(in: view)
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)

        switch sender.state {
        case .began:
            panBegan(location: location, translation: translation, velocity: velocity)
            break
        case .ended:
            panEnded(location: location, translation: translation, velocity: velocity)
            break
        case .changed:
            panChanged(location: location, translation: translation, velocity: velocity)
            break
        case .cancelled:
            break
        case .failed:
            break
        case .possible:
            break 
        }
    }
    
    private func panBegan(location: CGPoint, translation: CGPoint, velocity: CGPoint) {
        if playerSate == .play {
            playerSate = .pause
        }
        // 快进/快退
        if abs(velocity.x) > 800 || abs(velocity.y) > 800 {
            if translation.x > 0 {
                // 快进
                YYPlayer.share.seek(seconds: currentTime + intervalTime)
            } else {
                // 快退
                YYPlayer.share.seek(seconds: currentTime - intervalTime)
            }
        }
    }
    
    private func panEnded(location: CGPoint, translation: CGPoint, velocity: CGPoint) {
        if playerSate == .pause && isPlayed {
            playerSate = .play
        }
    }
    
    private func panChanged(location: CGPoint, translation: CGPoint, velocity: CGPoint) {
        print(location)
        // 声音/亮度
        if translation.y > 0 {
            print("下")
            if location.x > self.bounds.width / 2 {
                print("屏幕右侧")
                volumeSlider?.value = (volumeSlider?.value)! + 0.02
            } else {
                print("屏幕左侧")
                UIScreen.main.brightness = UIScreen.main.brightness + 0.02
            }
        } else {
            print("上")
            if location.x > self.bounds.width / 2 {
                print("屏幕右侧")
                volumeSlider?.value = (volumeSlider?.value)! - 0.02
            } else {
                print("屏幕左侧")
                UIScreen.main.brightness = UIScreen.main.brightness - 0.02
            }
        }
    }
    // 获取设置声音的slider
    lazy var volumeSlider: UISlider? = {
        let v = MPVolumeView()
        v.showsRouteButton = true
        v.showsVolumeSlider = true
        v.sizeToFit()
        v.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        for v in v.subviews {
            if (v.classForCoder.description() == "MPVolumeSlider") {
                return v as? UISlider
            }
        }
        return nil
    }()
    
    func topAndBottomViewAnimation() {
        UIView.animate(withDuration: 0.4, animations: {
            self.topBackView.alpha = self.topBackView.alpha == 0 ? 1 : 0
            self.bottomBackView.alpha = self.bottomBackView.alpha == 0 ? 1 : 0
            self.topMaskView.alpha = self.topMaskView.alpha == 0 ? 1 : 0
            self.bottomMaskView.alpha = self.bottomMaskView.alpha == 0 ? 1 : 0
        })
    }
    // 初始化配置
    private func config(url: URL) {
        maskImageView.isHidden = !isShowMaskImageView
        
        playAndPauseButton.playState = .pause
        
        YYPlayer.share.url = url
        
        // 添加闭包
        YYPlayer.share.displayLinkHandler = self.displayLinkHandler
        YYPlayer.share.playerInfo = self.playerInfo
        YYPlayer.share.playFinished = self.playFinished
    }
    
    // 实时更新进度条和时间的闭包
    lazy var displayLinkHandler: YYPlayer.DisplayLinkHandler = {
        [weak self] currentTime, catchTime, state in
        if let weakSelf = self {
            if state == .play {
                if !weakSelf.isSliderDragging {
                    weakSelf.currentTimeLabel.text = String(format: "%02d:%02d", Int(currentTime.seconds) / 60, Int(currentTime.seconds) % 60)
                    weakSelf.progressSlider.value = Float(currentTime.seconds / weakSelf.totalTime)
                    weakSelf.currentTime = currentTime.seconds
                }
            }
        }
    }
    
    // 获取总播放时间的闭包 此处隐藏转圈圈
    lazy var playerInfo: YYPlayer.PlayerInfo = {
        [weak self] totalTime, state in
        if let weakSelf = self {
            switch state {
            case .readyToPlay:
                weakSelf.totalTimeLabel.text = String(format: "%02d:%02d", Int(totalTime.seconds) / 60, Int(totalTime.seconds) % 60)
                weakSelf.totalTime = totalTime.seconds
            case .failed:
                
                break
            case .unknown:
                break
            }
            weakSelf.playerInfoState = state
        }
    }
    
    // 播放结束的闭包
    lazy var playFinished: YYPlayer.PlayFinished = {
        [weak self] in
        if let weakSelf = self {
            if weakSelf.isShowMaskImageView {
                weakSelf.maskImageView.isHidden = false
            }
            weakSelf.playerSate = .pause
            weakSelf.isFinished = true
            weakSelf.centerPlayButton.isHidden = false
            weakSelf.isPlayed = false
        }
    }
    
    // 退出界面时候调用
    public func releasePlayer() {
        YYPlayer.share.releaseAll()
        self.removeFromSuperview()
    }

}

// MARK: 获取当前的controller
extension YYPlayerView {
    
    fileprivate struct AssociatedKeys {
        static var playerViewController: UIViewController = UIViewController()
    }
    
    open var playerViewController: UIViewController? {
        get {
            guard let playerViewController = objc_getAssociatedObject(self, &AssociatedKeys.playerViewController) as? UIViewController else {
                var next = self.next
                while next != nil {
                    if next!.isKind(of: UIViewController.self) {
                        return next as? UIViewController
                    }
                    next = next?.next
                }
                return nil
            }
            return playerViewController
        }
    }
}

// MARK: YYPlayer
class YYPlayer: NSObject {

    // 监听四种keyPath
    private let kPath_status = "status"
    private let kPath_loadedTimeRanges = "loadedTimeRanges"
    private let kPath_playbackBufferEmpty = "playbackBufferEmpty"
    private let kPath_playbackLikelyToKeepUp = "playbackLikelyToKeepUp"
    
    // 单例
    static let share: YYPlayer = YYPlayer()
    
    // 实时播放的闭包
    typealias DisplayLinkHandler = (_ currentTime: CMTime, _ catchTime: CMTime?, _ state: YYPlayerState) -> ()
    // 播放内容的单例
    typealias PlayerInfo = (_ totalTime: CMTime, _ state: AVPlayerItemStatus) -> ()
    // 播放完成的单例
    typealias PlayFinished = () -> ()
    
    var displayLinkHandler: DisplayLinkHandler!
    var playerInfo: PlayerInfo!
    var playFinished: PlayFinished!
    
    var displayLink: CADisplayLink! // 实时刷新progress
    var cacheTime: CMTime? // 缓存时间
    var playerInfoState: AVPlayerItemStatus = .unknown
    
    override init() {
        super.init()
    }
    
    // url
    var url: URL? {
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
    
    lazy var playerLayer: AVPlayerLayer = {
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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
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
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: YYPlayerButton
class YYPlayerButton: UIButton {
    
    var playState: YYPlayerState! {
        didSet {
            switch playState {
            case .play:
                self.isSelected = true
            case .pause:
                self.isSelected = false
            case .unknow:
                print("更改状态时候发生未知错误")
            case .none:
                break
            case .some(_):
                break
            }
        }
    }
    
    var fullState: YYPlayerScreenState! {
        didSet {
            switch fullState {
            case .full:
                self.isSelected = true
            case .small:
                self.isSelected = false
            case .none:
                break
            case .some(_):
                break
            }
        }
    }
}

// MARK: YYPlayerGradualChangeView 渐变视图
class YYPlayerGradualChangeView: UIView {
    
    @IBInspectable var isUpDeep: Bool = false
    
    var gradientLayer: CAGradientLayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let gradientLayer = initGradientLayer()
        self.layer.addSublayer(gradientLayer)
        gradientLayer.frame = self.layer.bounds
    }
    
    func initGradientLayer() -> CAGradientLayer {
        if let g = gradientLayer {
            return g
        }
        let g = CAGradientLayer()
        let colors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.8).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor,
            ]
        let locations = [
            0.0, 1
        ]
        g.colors = colors
        g.locations = locations as [NSNumber]
        let startPoint = self.isUpDeep ? CGPoint(x: 0.5, y: 0) : CGPoint(x: 0.5, y: 1)
        let endPoint = self.isUpDeep ? CGPoint(x: 0.5, y: 1) : CGPoint(x: 0.5, y: 0)
        g.startPoint = startPoint
        g.endPoint = endPoint
        
        gradientLayer = g
        
        return g
    }
}

// MARK: extension UIResponder

var extension_key: UInt = 1205
extension UIResponder {
    
    var allowRotation: Bool? {
        get {
            return objc_getAssociatedObject(self, &extension_key) as? Bool
        }
        set(newValue) {
            objc_setAssociatedObject(self, &extension_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // UIDevice.current.setValue(value, forKey: kOrientation) 之后调用此方法
    @objc(application:supportedInterfaceOrientationsForWindow:) func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if allowRotation == true {
            return .landscapeRight
        } else {
            return .portrait
        }
    }
}
