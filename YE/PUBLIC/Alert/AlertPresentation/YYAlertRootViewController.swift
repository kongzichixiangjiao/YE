//
//  YYAlertRootViewController.swift
//  YE
//
//  Created by 侯佳男 on 2018/1/2.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

enum YYAlertCellType: String {
    case normal = "Nomal"
    case text = "Text"
    case loading = "Loading"
    case bottom = "Bottom"
    case sheet = "Sheet"
    case alert = "Alert"
}

class YYAlertRootViewController: UITableViewController {
    
    var dataSource: [YYAlertCellType] = [.normal, .text, .loading, .bottom, .sheet, .alert]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.scrollWasEnabled = true
        tableView.register(UINib(nibName: "YYAlertRootCell", bundle: nil), forCellReuseIdentifier: "YYAlertRootCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YYAlertRootCell")
        cell?.textLabel?.text = dataSource[indexPath.row].rawValue
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = dataSource[indexPath.row]
        switch type {
        case .normal:
            let d = YYPresentationDelegate(animationType: .sheet, isShowMaskView: true)
            let vc = AnimationBaseViewController(nibName: "AnimationBaseViewController", bundle: nil, delegate: d)
            vc.clickedHandler = {
                tag, model in
                print(tag)
            }
            self.present(vc, animated: true, completion: nil)
            break
        case .text:
            let d = YYPresentationDelegate(animationType: .middle)
            let vc = YYAlertTextViewController(nibName: "YYAlertTextViewController", bundle: nil, delegate: d)
            vc.duration = 2.0
            self.present(vc, animated: true, completion: nil)
            break
        case .loading:
            let d = YYPresentationDelegate(animationType: .middle)
            let vc = YYAlertLoadingViewController(nibName: "YYAlertLoadingViewController", bundle: nil, delegate: d)
            vc.duration = 2.0
            self.present(vc, animated: true, completion: nil)
            break
        case .bottom:
            let d = YYPresentationDelegate(animationType: .bottom, isShowMaskView: false)
            let vc = YYAlertBottomTextViewController(nibName: "YYAlertBottomTextViewController", bundle: nil, delegate: d)
            vc.duration = 2.0
            self.present(vc, animated: true, completion: nil)
            break
        case .sheet:
            let d = YYPresentationDelegate(animationType: .sheet)
            let vc = YYAlertSheetViewController(nibName: "YYAlertSheetViewController", bundle: nil, delegate: d)
            vc.clickedHandler = {
                tag, model in
                print(tag, model ?? "")
            }
            self.present(vc, animated: true, completion: nil)
            break
        case .alert:
            let d = YYPresentationDelegate(animationType: .alert, isShowMaskView: true)
            let vc = YYAlertAlertViewController(nibName: "YYAlertAlertViewController", bundle: nil, delegate: d)
            vc.clickedHandler = {
                tag, model in
                print(tag, model ?? "")
            }
            self.present(vc, animated: true, completion: nil)
            break
            
            
        }
    }
    
}

