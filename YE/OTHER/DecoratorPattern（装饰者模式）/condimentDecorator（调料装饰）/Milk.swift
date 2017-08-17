//
//  Milk.swift
//  YE
//
//  Created by 侯佳男 on 2017/8/16.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation

class Milk: DecoratorBase {
    var beverage: Beverage!
    
    convenience init(beverage: Beverage) {
        self.init()
        self.beverage = beverage
    }
    
    override var name: String {
        get {
            return "Milk" + "+" + self.beverage.name
        }
        set {
            self.name = newValue
        }
    }
    
    override var cost: Double {
        get {
            return 1.0 + self.beverage.cost
        }
        set {
            self.cost = newValue
        }
    }
    
}
