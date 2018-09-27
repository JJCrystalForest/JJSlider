//
//  SliderViewModel.swift
//  Schaeffler
//
//  Created by crystalforest on 2018/9/7.
//  Copyright © 2018年 crystalforest. All rights reserved.
//

import UIKit

struct SliderViewModel {
    
}

struct SliderConfig {
    static let kMainPageDistance = UIDevice.current.model == "iPad" ? GlobalDefine.screenWidth / 3 : 70  // 打开左侧窗时，右视图露出的宽度
    static let kSideCenterX : CGFloat = -50  // 左侧初始偏移值
    static var kSideExposedWidth : CGFloat {  // 打开时sideVC所占据的宽度
        return GlobalDefine.screenWidth - kMainPageDistance
    }
    static let kSideScale : CGFloat = 1.0 // side初始缩放比例
    static let kMainScale : CGFloat = 1.0 // 打开左侧窗时，主视图的缩放比例
    static let kMaxMarkAlpha : CGFloat = 0.5 // 蒙版透明度最大值
    static var kCouldChangeDeckStateDistance : CGFloat {  // 滑动距离大于此数时，状态改变（关 -> 开 或 开 -> 关）
        return kSideExposedWidth / 4.0
    }
    static var kMainPageCenter : CGPoint {  // 打开左侧窗时，主视图中心点
        return CGPoint(x: GlobalDefine.screenWidth + GlobalDefine.screenWidth * kMainScale * 0.5 - kMainPageDistance, y: GlobalDefine.screenHeight * 0.5)
    }
}
