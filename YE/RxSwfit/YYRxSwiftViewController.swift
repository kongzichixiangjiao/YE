//
//  YYRxSwiftViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/8/25.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

public let disposeBag = DisposeBag()

class YYRxSwiftViewController: UIViewController {
    
    @IBOutlet weak var t: UILabel!
    @IBOutlet weak var b: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        t.text = "0"

        action()
    }
    
    func action() {
        let e = b.rx.tap
        e.subscribe(onNext: { [weak self] in
            if let weakSelf = self {
                let n = Int(weakSelf.t.text!)
                weakSelf.t.text = String(n! + 1)
            }
        }).disposed(by: disposeBag)
        
    }
    
    func longAtion() {
        
        let l = UILongPressGestureRecognizer()
        // .single()
        l.rx.event.subscribe(onNext: {
            [weak self] long in
            if let weakSelf = self {
                if long.state == .began {
                    let n = Int(weakSelf.t.text!)
                    weakSelf.t.text = String(n! + 2)
                }
            }
        }).disposed(by: disposeBag)
        self.view.addGestureRecognizer(l)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
