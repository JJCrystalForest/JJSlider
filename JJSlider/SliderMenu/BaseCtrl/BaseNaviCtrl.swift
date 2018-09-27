//
//  BaseNaviCtrl.swift
//  Schaeffler
//
//  Created by crystalforest on 2018/9/7.
//  Copyright © 2018年 crystalforest. All rights reserved.
//

import UIKit

class BaseNaviCtrl: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        let bar = UINavigationBar.appearance()
        bar.isTranslucent = false
        bar.barTintColor = UIColor.white
        bar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : GlobalDefine.appMainFontColor,
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)
        ]
        
        bar.shadowImage = UIImage.image(withColor: GlobalDefine.appThemeColor)
        super.loadView()
    }

}

extension BaseNaviCtrl {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 防止重复 push
        if topViewController != nil {
            if topViewController == viewController { return }
        }

        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = viewControllers.count > 0 ? true : false
        
        super.pushViewController(viewController, animated: animated)

        // 解决自定义 leftbarItem 后侧滑返回功能失效的问题，还需要在 baseVC 的 viewDidAppear 里面做一些处理
        viewController.navigationController?.interactivePopGestureRecognizer?.delegate = self

    }
    
}

extension BaseNaviCtrl : UIGestureRecognizerDelegate {
    
}
