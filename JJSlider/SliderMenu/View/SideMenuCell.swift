//
//  SideMenuCell.swift
//  Schaeffler
//
//  Created by crystalforest on 2018/9/6.
//  Copyright © 2018年 crystalforest. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var iconIV: UIImageView!
    @IBOutlet weak var titleLbLeft: NSLayoutConstraint!
    
    static let identifier = "SideMenuCellID"
    
    var model : SideMenuCellModel? {
        didSet {
            if model?.icon == nil {
                iconIV.isHidden = true
                titleLbLeft.constant = -38
            } else {
                iconIV.isHidden = false
                titleLbLeft.constant = 8
                iconIV.image = model?.icon
            }
            titleLb.text = model?.title
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}

