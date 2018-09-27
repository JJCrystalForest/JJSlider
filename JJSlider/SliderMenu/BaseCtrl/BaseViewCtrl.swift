//
//  BaseViewCtrl.swift
//  Schaeffler
//
//  Created by crystalforest on 2018/9/19.
//  Copyright © 2018年 crystalforest. All rights reserved.
//

import UIKit

class BaseViewCtrl: UIViewController {
    
    /// 是否显示返回按钮
    var isShowBackItem = true {
        didSet(newValue) {
            guard let vcCount = navigationController?.viewControllers.count else { return }
            if newValue == true && vcCount > 1 {
                let item = UIBarButtonItem(image: UIImage.init(named: "back_icon"), style: .plain, target: self, action: #selector(backAction))
                navigationItem.leftBarButtonItem = item
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initConfig()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if navigationController?.viewControllers.count == 1 {
            SliderManager.shared.sideVC?.enablePanGesture(true)
        } else {
            SliderManager.shared.sideVC?.enablePanGesture(false)
        }
    }

}

extension BaseViewCtrl {  // api
    
    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    /// 设置 titleView
    ///
    /// - Parameter imageName: 图片名
    func setTitleView(withImageName imageName : String) {
        
        let backView = UIView.init()
        backView.backgroundColor = UIColor.clear
        
        guard let titleImage = UIImage(named: imageName) else { return }
        let titleIV = UIImageView.init(image: titleImage)
        titleIV.size = titleImage.size
        backView.size = titleImage.size
        titleIV.center = backView.center
        
        backView.addSubview(titleIV)
        navigationItem.titleView = backView
        
    }
    
    /// 设置背景图片
    ///
    /// - Parameter imageNamed: 背景图片名字
    func setBackground(withImageNamed imageNamed : String) {
        
        guard let backImage = UIImage(named: imageNamed) else { return }
        let backIV = UIImageView.init(image: backImage)
        backIV.frame = GlobalDefine.screenRect
        backIV.isUserInteractionEnabled = true
        view.insertSubview(backIV, at: 0)
        
    }
    
}

private extension BaseViewCtrl {
    
    func initConfig() {
        
        view.backgroundColor = GlobalDefine.baseBackgroundColor
        
        isShowBackItem = true
        
        setBackground(withImageNamed: "app_bg")
        
    }
    
}
