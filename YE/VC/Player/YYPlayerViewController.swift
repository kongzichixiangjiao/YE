//
//  YYPlayerViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/1.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import Kingfisher

class YYPlayerViewController: UIViewController {

    @IBOutlet weak var playerBackView: UIView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // http://qiniu.puxinasset.com/Fqd1WTazeaDOih8SSxGZ33SnNyMs
        self.playerBackView.addSubview(pView)
        
        pView.snp.makeConstraints({ (make) in
            make.edges.equalTo(playerBackView)
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
//        MediaManager.sharedInstance.playEmbeddedVideo(url:"http://qiniu.puxinasset.com/099f507aed7c5799d5ff40386a1a9615.mp4".ga_url!, embeddedContentView: playerBackView)

//        playerBackView.addSubview(playerView)
//        playerView.maskImageView.kf.setImage(with: URL(string: "http://qiniu.puxinasset.com/Fqd1WTazeaDOih8SSxGZ33SnNyMs"))
//        playerView.snp.makeConstraints { (make) in
//            make.edges.equalTo(playerBackView)
//        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
    }
    
    let pView = YYPlayerView.loadPlayerView().then {
        $0.urlString = "http://qiniu.puxinasset.com/099f507aed7c5799d5ff40386a1a9615.mp4"
    }
    
    // 视频播放器
//    lazy var playerView: LYPlayerView = {
//        let playerView = LYPlayerView(url: "http://qiniu.puxinasset.com/099f507aed7c5799d5ff40386a1a9615.mp4".ga_url!)
//        playerView.assetName = "普信视频"
//        playerView.delegate = self as? LYPlayerViewDelegate
//
//        return playerView
//    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
//        MediaManager.sharedInstance.releasePlayer()
//        self.playerView.releasePlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("22222")
    }
}

extension YYPlayerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
