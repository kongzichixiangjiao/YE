//
//  Blend.swift
//  YE
//
//  Created by 侯佳男 on 2017/8/16.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation

class HouseBlend: DecoratorBase {
    override var name: String {
        get {
            return "HouseBlend"
        }
        set {
            self.name = newValue
        }
    }
    
   override var cost: Double {
        get {
            return 2.0
        }
        set {
            self.cost = newValue
        }
    }

}
