//
//  YYRxSwiftPlusViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/7.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class YYRxSwiftPlusViewController: UIViewController {
    
    @IBOutlet weak var t1: UITextField!
    @IBOutlet weak var t2: UITextField!
    @IBOutlet weak var t3: UITextField!
    @IBOutlet weak var b: UIButton!
    @IBOutlet weak var l: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.combineLatest(t1.rx.text.orEmpty,
                                 t2.rx.text.orEmpty,
                                 t3.rx.text.orEmpty) {
                                    v1, v2, v3 -> Int in
                                    return (Int(v1) ?? 0) + (Int(v2) ?? 0) + (Int(v3) ?? 0)
            }.map({$0.description})
            .bind(to: l.rx.text)
            .disposed(by: self.rx.disposeBag)
    }
    
    @IBAction func b(_ sender: UIButton) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

