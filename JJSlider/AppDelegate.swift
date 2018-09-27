//
//  AppDelegate.swift
//  JJSlider
//
//  Created by crystalforest on 2018/9/27.
//  Copyright © 2018 crystalforest. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initWindow()
        return true
    }

    func initWindow() {
        window?.backgroundColor = UIColor.white
        let nvc = BaseNaviCtrl.init(rootViewController: ViewController())
        let sliderVC = SliderViewCtrl.init(SideMenuViewCtrl(), nvc)
        window?.rootViewController = sliderVC
        window?.makeKeyAndVisible()
    }


}

