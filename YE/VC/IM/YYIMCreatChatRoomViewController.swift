//
//  YYIMCreatChatRoomViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/14.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import EaseUILite

class YYIMCreatChatRoomViewController: YYBaseViewController {
    
    @IBOutlet weak var roomTitleTextField: UITextField!
    @IBOutlet weak var introTextView: UITextView!
    
    @IBAction func finishedAction(_ sender: UIButton) {
        myRegignFirstResponder()
        
//        createChatroom()
    }
    
    func createChatroom() {
        DispatchQueue.global().async {
            EMClient.shared().roomManager.createChatroom(withSubject: self.roomTitleTextField.text, description: self.introTextView.text, invitees: nil, message: "进来吧 小粑粑!", maxMembersCount: 10) { (room, error) in
                if let e = error {
                    print("error: \(e.errorDescription)")
                    return
                }
                DispatchQueue.main.async {
                    self.showHint("chatroom.create.success: \(String(describing: room))")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTitle = "创建聊天室"
        //注册聊天室回调
        EMClient.shared().roomManager.add(self, delegateQueue: nil)
    }
    
    deinit {
        EMClient.shared().roomManager.remove(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        myRegignFirstResponder()
    }
    
    private func myRegignFirstResponder() {
        introTextView.resignFirstResponder()
        roomTitleTextField.resignFirstResponder()
    }
}

extension YYIMCreatChatRoomViewController: EMChatroomManagerDelegate {
    
}
