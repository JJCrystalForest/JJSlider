//
//  SliderViewCtrl.swift
//  Schaeffler
//
//  Created by crystalforest on 2018/9/6.
//  Copyright © 2018年 crystalforest. All rights reserved.
//

import UIKit

class SliderViewCtrl: BaseViewCtrl {
 
    // MARK: - 属性
    var sideVC : UIViewController
    var mainVC : UIViewController
    
    private lazy var panGesture : UIGestureRecognizer = {
        var pan = UIPanGestureRecognizer.init(target: self, action:#selector(self.pan(_:)))
        pan.cancelsTouchesInView = true
        pan.delegate = self
        return pan
    }()
    
    private lazy var tapGesture : UIGestureRecognizer = {
        var tap = UITapGestureRecognizer.init(target: self, action: #selector(self.tap(_:)))
        tap.numberOfTapsRequired = 1
        tap.cancelsTouchesInView = true
        return tap
    }()
    
    private lazy var markView : UIView = {
        var view = UIView.init(frame: self.sideVC.view.bounds)
        view.backgroundColor = UIColor.black
        view.alpha = 0
        // 添加手势
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private lazy var sideTableView : UITableView = {
        var sideTableView : UITableView?
        for view in sideVC.view.subviews {
            if view is UITableView {
                sideTableView = view as? UITableView
            }
        }
        sideTableView?.backgroundColor = UIColor.clear
        sideTableView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        return sideTableView!
    }()
    
    private var isClose = false
    private var scalef : CGFloat = 0.0  // 实时横向位移
    private var speedf : CGFloat = 0.8  // 滑动速率
    
    // MARK: - init
    init(_ sideVC : UIViewController, _ mainVC : UIViewController) {
        self.sideVC = sideVC
        self.mainVC = mainVC
        super.init(nibName: nil, bundle: nil)
        self.initConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sideVC.view.isHidden = false
    }
    
}

extension SliderViewCtrl {  // api
    
    func enablePanGesture(_ isEnabled : Bool) {
        panGesture.isEnabled = isEnabled
    }
    
}

fileprivate extension SliderViewCtrl {
    func initConfig() {
        
        // 设置manager的两个控制器
        SliderManager.shared.sideVC = self
        SliderManager.shared.mainVC = mainVC as? UINavigationController
        
        // 添加子控制器
        addChild(sideVC)
        addChild(mainVC)
        
        // 添加手势
        mainVC.view.addGestureRecognizer(panGesture)
        sideVC.view.isHidden = true
        view.addSubview(sideVC.view)

        view.addSubview(sideVC.view)
        view.addSubview(mainVC.view)
        
        // 蒙版
        mainVC.view.addSubview(markView)
        
        isClose = true
        
    }
}

fileprivate extension SliderViewCtrl {
    @objc func pan(_ rec : UIPanGestureRecognizer) {  // 滑动事件
        
        let point = rec.translation(in: view)
        scalef = point.x * speedf + scalef
        
        var needMoveWithTap = true
        if (mainVC.view.x <= 0) && (scalef <= 0) || (mainVC.view.x >= SliderConfig.kSideExposedWidth) && (scalef >= 0) {
            // 边界值管控
            scalef = 0
            needMoveWithTap = false
        }
        
        guard let recView = rec.view else { return }
        // 根据视图位置判断是左滑还是右滑
        if (needMoveWithTap == true) && (recView.x >= 0) && (recView.x <= SliderConfig.kSideExposedWidth) {
            
            var recCenterX = recView.centerX + point.x * speedf
            if recCenterX < GlobalDefine.screenWidth * 0.5 - 2 {
                recCenterX = GlobalDefine.screenWidth * 0.5
            }
            let recCenterY = recView.center.y
            recView.center = CGPoint(x: recCenterX, y: recCenterY)
            
            // scale 1.0 ~ mainPageScale
            let scale = 1 - (1 - SliderConfig.kMainScale) * (recView.x / SliderConfig.kSideExposedWidth)
            
            recView.transform = CGAffineTransform.identity.scaledBy(x: scale, y: scale)
            rec.setTranslation(CGPoint(x: 0, y: 0), in: view)
            
            let leftTabCenterX = SliderConfig.kSideCenterX + (SliderConfig.kSideExposedWidth * 0.5 - SliderConfig.kSideCenterX) * (recView.x / SliderConfig.kSideExposedWidth)
            
            // leftScale kSideScale ~ 1.0
            let leftScale = SliderConfig.kSideScale + (1 - SliderConfig.kSideScale) * (recView.x / SliderConfig.kSideExposedWidth)
            
            sideVC.view.center = CGPoint(x: leftTabCenterX, y: GlobalDefine.screenHeight * 0.5)
            sideVC.view.transform = CGAffineTransform.identity.scaledBy(x: leftScale, y: leftScale)
            
            let tempAlpha = SliderConfig.kMaxMarkAlpha * (recView.x / SliderConfig.kSideExposedWidth)
            markView.alpha = tempAlpha
            
        } else {
            if mainVC.view.x < 0 {
                close()
                scalef = 0
            } else if mainVC.view.x > SliderConfig.kSideExposedWidth {
                open()
                scalef = 0
            }
        }
        
        // 手势结束后修正位置，超过约一半时向多出的一半偏移
        if rec.state == .ended {
            if abs(scalef) > SliderConfig.kCouldChangeDeckStateDistance {
                isClose ? open() : close()
            } else {
                isClose ? close() : open()
            }
            scalef = 0
        }
    }
    
    @objc func tap(_ tap : UITapGestureRecognizer) {  // 轻点手势（收起侧滑）
        if isClose == false && tap.state == .ended { close() }
    }
    
}

extension SliderViewCtrl {
    
    func close() {
        
        UIView.beginAnimations(nil, context: nil)
        mainVC.view.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
        mainVC.view.center = CGPoint(x: GlobalDefine.screenWidth * 0.5, y: GlobalDefine.screenHeight * 0.5)
        
        sideVC.view.center = CGPoint(x: SliderConfig.kSideCenterX, y: GlobalDefine.screenHeight * 0.5)
        sideVC.view.transform = CGAffineTransform.identity.scaledBy(x: SliderConfig.kSideScale, y: SliderConfig.kSideScale)
        markView.alpha = 0
        
        UIView.commitAnimations()
        
        isClose = true

    }
    
    func open() {
        
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
        UIView.beginAnimations(nil, context: nil)
        mainVC.view.transform = CGAffineTransform.identity.scaledBy(x: SliderConfig.kMainScale, y: SliderConfig.kMainScale)
        mainVC.view.center = SliderConfig.kMainPageCenter
        
        sideVC.view.center = CGPoint(x: SliderConfig.kSideExposedWidth * 0.5, y: GlobalDefine.screenHeight * 0.5)
        sideVC.view.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
        markView.alpha = 0.5
        
        UIView.commitAnimations()
        
        isClose = false
    
    }
    
}

extension SliderViewCtrl : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
}
