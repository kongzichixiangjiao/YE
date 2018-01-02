//
//  YYTransition+None.swift
//  YYTransition
//
//  Created by 侯佳男 on 2018/1/2.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation
import UIKit

extension YYTransition {
    func noneExecuteAnimationBack(using context: UIViewControllerContextTransitioning) {
        let containerView = context.containerView
        guard let fromView = context.view(forKey: .from) else {
            return
        }
        guard let toView = context.view(forKey: .to) else {
            return
        }
        
        containerView.addSubview(fromView)
        containerView.addSubview(toView)

        context.completeTransition(!context.transitionWasCancelled)
    }
}

