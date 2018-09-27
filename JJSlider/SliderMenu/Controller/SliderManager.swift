//
//  SliderManager.swift
//  Schaeffler
//
//  Created by crystalforest on 2018/9/7.
//  Copyright © 2018年 crystalforest. All rights reserved.
//  用来控制侧滑控制器

import UIKit

class SliderManager : NSObject {

    static let shared = SliderManager()
    
    override required init() {
        
    }
    
    override func copy() -> Any {
        return self
    }
    
    override func mutableCopy() -> Any {
        return self
    }
    
    var sideVC : SliderViewCtrl?
    var mainVC : UINavigationController?

}
