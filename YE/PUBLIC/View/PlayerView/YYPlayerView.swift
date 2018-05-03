//
//  YYPlayerView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/27.
//  Copyright © 2017年 侯佳男. All rights reserved.
// 提交github
//  播放器


import UIKit
import MediaPlayer
import YYPlayer

open class YYPlayerView: UIView {
    
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
   static public func loadPlayerView() -> YYPlayerView {
        return Bundle.main.loadNibNamed("YYPlayerView", owner: nil, options: nil)?.last as! YYPlayerView
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
    private var isCanPlay: Bool = false // 是否可以播放
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
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
        if !isCanPlay {
            return
        }
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
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        // 横竖屏切换从新设置playerLayer大小， 第一次添加playerLayer也会走起
        screenView.layer.insertSublayer(YYPlayer.share.playerLayer, below: self.maskImageView.layer)
        YYPlayer.share.playerLayer.frame = bounds
    }
    
    override open func awakeFromNib() {
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
        
        vidoeFirstImage(url: url)
        
        playAndPauseButton.playState = .pause
        
        YYPlayer.share.url = url
        
        // 添加闭包
        YYPlayer.share.displayLinkHandler = self.displayLinkHandler
        YYPlayer.share.playerInfo = self.playerInfo
        YYPlayer.share.playFinished = self.playFinished
    }
    
    // 第一帧图片获取
    private func vidoeFirstImage(url:URL) {
        if !maskImageView.isHidden {
            DispatchQueue.global().async {
                let opts = [AVURLAssetPreferPreciseDurationAndTimingKey : false]
                let asset = AVURLAsset(url: url, options: opts)
                let generator = AVAssetImageGenerator(asset: asset)
                generator.appliesPreferredTrackTransform = true
                var actualTime = CMTimeMake(0,600) //  CMTimeMake(a,b) a/b = 当前秒   a当前第几帧, b每秒钟多少帧
                let time = CMTimeMakeWithSeconds(10, 60) //  CMTimeMakeWithSeconds(a,b) a当前时间,b每秒钟多少帧
                var cgImage: CGImage!
                do {
                    cgImage = try generator.copyCGImage(at: time, actualTime: &actualTime)
                    DispatchQueue.main.async {
                        self.maskImageView.image = UIImage(cgImage: cgImage)
                    }
                } catch let error as NSError{
                    print(error)
                }
            }
        }
    }
    
    // 实时更新进度条和时间的闭包
    lazy var displayLinkHandler: YYPlayer.DisplayLinkHandler = {
        [weak self] currentTime, catchTime, state in
        if let weakSelf = self {
            weakSelf.isCanPlay = (state == .play)
            weakSelf.loadingView.isHidden = (state == .play)
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
                weakSelf.loadingView.isHidden = true
                weakSelf.isCanPlay = true
                weakSelf.totalTimeLabel.text = String(format: "%02d:%02d", Int(totalTime.seconds) / 60, Int(totalTime.seconds) % 60)
                weakSelf.totalTime = totalTime.seconds
            case .failed:
                weakSelf.loadingView.isHidden = false
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



