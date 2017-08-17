//
//  DecoratorBase.swift
//  YE
//
//  Created by 侯佳男 on 2017/8/16.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation

/*
 
 var espresso: DecoratorBase = HouseBlend()
 print(espresso.name, espresso.cost)
 
 espresso = Milk(beverage: espresso)
 print(espresso.name, espresso.cost)
 
 */

class DecoratorBase: Beverage {
    var name: String {
        get {
            return ""
        }
        set {
            self.name = newValue
        }
    }
    
    var cost: Double {
        get {
            return 0.0
        }
        set {
            self.cost = newValue
        }
    }
}
