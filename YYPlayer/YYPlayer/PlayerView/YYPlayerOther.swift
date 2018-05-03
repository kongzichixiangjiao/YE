//
//  YYPlayerOther.swift
//  YYPlayer
//
//  Created by 侯佳男 on 2018/5/2.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

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
 *  13、获取图片第一帧
 */

// MARK: 播放器状态枚举
public enum YYPlayerState: Int {
    case play = 1, pause = 2, stop = 3, finished = 4, unknow = 99
}

// MARK: 播放器屏幕枚举
public enum YYPlayerScreenState: Int {
    case full = 1, small = 2
}
