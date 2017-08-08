//
//  YYPlayerView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/27.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  播放器

import UIKit
import MediaPlayer

class YYPlayerView: UIView {
    
    var playerItem: AVPlayerItem!
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    var timeLabel: UILabel!
    var slider: UISlider!
    var progressView: UIProgressView!
    
    var link: CADisplayLink!
    
    var sliding: Bool = false
    
    var url: String!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initPlayer()
        
        initTimeLabel()
        
        initDisplayLink()
        
        initSlider()
        
        initProgressView()
        
        initTapAction()
        
    }
    
    func initPlayer() {
        guard let url = URL(string: "http://testqiniuapp.ztyijia.com/FrLxwnzRmvnm_ZTmAiIdJqdTWL7Z?e=1495861741&token=7nwN9TlbbyaMgMqmzXKEAB5bZ_JkVvoDx78pEg_e:QjsJtTUTR3cryZRRyOQQQjLKKnA=&e=1495861741&token=7nwN9TlbbyaMgMqmzXKEAB5bZ_JkVvoDx78pEg_e:v6L84GY-w4UpI2l5iAfvJWzgBEI=") else { fatalError("连接错误") }
        
        playerItem = AVPlayerItem(url: url) // 创建视频资源
        // 监听缓冲进度改变
        playerItem.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        // 监听状态改变
        playerItem.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        // 将视频资源赋值给视频播放对象
        player = AVPlayer(playerItem: playerItem)
        // 初始化视频显示layer
        playerLayer = AVPlayerLayer(player: player)
        // 设置显示模式
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect
        playerLayer.contentsScale = UIScreen.main.scale
        playerLayer.frame = self.bounds
        // 赋值给自定义的View
        self.layer.addSublayer(playerLayer)
    }
    func initTimeLabel() {
        timeLabel = UILabel()
        timeLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        timeLabel.textColor = UIColor.white
        timeLabel.backgroundColor = UIColor.blue
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(timeLabel)
    }
    
    func initDisplayLink() {
        link = CADisplayLink(target: self, selector: #selector(update))
        link.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
    }
    
    func initSlider() {
        slider = UISlider()
        slider.frame = CGRect(x: 0, y: self.frame.size.height - 15, width: self.frame.size.width, height: 15)
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0
        // 从最大值滑向最小值时杆的颜色
        slider.maximumTrackTintColor = UIColor.clear
        // 从最小值滑向最大值时杆的颜色
        slider.minimumTrackTintColor = UIColor.white
        // 在滑块圆按钮添加图片
        slider.setThumbImage(UIImage(named:"slider_thumb"), for: .normal)
        self.addSubview(slider)
        
        // 按下的时候
        slider.addTarget(self, action: #selector(sliderTouchDown(slider:)), for: .touchDown)
        // 弹起的时候
        slider.addTarget(self, action: #selector(sliderTouchUpOut(slider:)), for: .touchUpOutside)
        slider.addTarget(self, action: #selector(sliderTouchUpOut(slider:)), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderTouchUpOut(slider:)), for: .touchCancel)
    }
    
    func initProgressView() {
        progressView = UIProgressView()
        progressView.frame = CGRect(x: 0, y: self.frame.size.height - 15, width: self.frame.size.width, height: 15)
        progressView.backgroundColor = UIColor.lightGray
        progressView.tintColor = UIColor.red
        progressView.progress = 0
        self.insertSubview(progressView, belowSubview: slider)
    }
    
    func avalableDurationWithplayerItem() -> TimeInterval{
        guard let loadedTimeRanges = player?.currentItem?.loadedTimeRanges, let first = loadedTimeRanges.first else {fatalError()}
        let timeRange = first.timeRangeValue
        let startSeconds = CMTimeGetSeconds(timeRange.start)
        let durationSecound = CMTimeGetSeconds(timeRange.duration)
        let result = startSeconds + durationSecound
        return result
    }
    
    func sliderTouchDown(slider:UISlider){
        self.sliding = true
    }
    
    func sliderTouchUpOut(slider:UISlider){
        // TODO: -代理处理
        player(sliderTouchUpOut: slider)
    }
    
    // 滑动滑块 指定播放位置
    func player(sliderTouchUpOut slider: UISlider) {
        //当视频状态为AVPlayerStatusReadyToPlay时才处理
        if self.player.status == AVPlayerStatus.readyToPlay{
            let duration = slider.value * Float(CMTimeGetSeconds(self.player.currentItem!.duration))
            let seekTime = CMTimeMake(Int64(duration), 1)
            // 指定视频位置
            self.player.seek(to: seekTime, completionHandler: { (b) in
                // 别忘记改状态
                self.sliding = false
            })
        }
    }
    
    func update(){
        //暂停的时候
        
        // 当前播放到的时间
        let currentTime = CMTimeGetSeconds(self.player.currentTime())
        // 总时间
        let totalTime   = TimeInterval(playerItem.duration.value) / TimeInterval(playerItem.duration.timescale)
        // timescale 这里表示压缩比例
        let timeStr = "\(formatPlayTime(secounds: currentTime))/\(formatPlayTime(secounds: totalTime))" // 拼接字符串
        self.timeLabel.text = timeStr // 赋值
        // TODO: 播放进度
        slider.value = Float(currentTime/totalTime)
        // 滑动不在滑动的时候
        if !self.sliding{
            // 播放进度
            self.slider.value = Float(currentTime/totalTime)
        }
    }
    
    func formatPlayTime(secounds:TimeInterval)->String{
        if secounds.isNaN{
            return "00:00"
        }
        let Min = Int(secounds / 60)
        let Sec = Int(secounds.truncatingRemainder(dividingBy: 60.0))
        return String(format: "%02d:%02d", Min, Sec)
    }
    
    func initTapAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(sender:)))
        self.addGestureRecognizer(tap)
    }
    
    func tapAction(sender: UITapGestureRecognizer) {
        
        play()
    }
    
    func play() {
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let playerItem = object as? AVPlayerItem else { return }
        if keyPath == "loadedTimeRanges" {
            print(2)
            // 通过监听AVPlayerItem的"loadedTimeRanges"，可以实时知道当前视频的进度缓冲
            let loadedTime = avalableDurationWithplayerItem()
            let totalTime = CMTimeGetSeconds(playerItem.duration)
            let percent = loadedTime/totalTime // 计算出比例
            // 改变进度条
            self.progressView.progress = Float(percent)
        } else if keyPath == "status" {
            // 监听状态改变
            if playerItem.status == AVPlayerItemStatus.readyToPlay {
                // 只有在这个状态下才能播放
                self.player.play()
            } else {
                print("加载异常")
            }
        }
    }
    
    deinit{
        playerItem.removeObserver(self, forKeyPath: "loadedTimeRanges")
        playerItem.removeObserver(self, forKeyPath: "status")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
