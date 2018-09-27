//
//  SideMenuFooter.swift
//  Schaeffler
//
//  Created by crystalforest on 2018/9/6.
//  Copyright © 2018年 crystalforest. All rights reserved.
//

import UIKit

class SideMenuFooter: UIView {

    @IBOutlet weak var iconIV_A: UIImageView!
    @IBOutlet weak var titleLb_A: UILabel!
    @IBOutlet weak var iconIV_B: UIImageView!
    @IBOutlet weak var titleLb_B: UILabel!
    
    @IBOutlet weak var titleLb_A_Left: NSLayoutConstraint!
    @IBOutlet weak var titleLb_B_Left: NSLayoutConstraint!
    
    var model : SideMenuFooterModel? {
        didSet {
            if model?.iconA == nil {
                iconIV_A.isHidden = true
                titleLb_A_Left.constant = -38
            } else {
                iconIV_A.isHidden = false
                iconIV_A.image = model?.iconA
                titleLb_A_Left.constant = 0
            }
            titleLb_A.text = model?.titleA
            
            if model?.iconB == nil {
                iconIV_B.isHidden = true
                titleLb_B_Left.constant = -38
            } else {
                iconIV_B.isHidden = false
                iconIV_B.image = model?.iconB
                titleLb_B_Left.constant = 0
            }
            titleLb_B.text = model?.titleB
        }
    }
    
}

extension SideMenuFooter {
    
    static func loadFromNib() -> SideMenuFooter {
        return Bundle.main.loadNibNamed("SideMenuFooter", owner: nil, options: nil)?[0] as! SideMenuFooter
    }
    
}
