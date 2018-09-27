//
//  LeftMenuModel.swift
//  Schaeffler
//
//  Created by crystalforest on 2018/9/5.
//  Copyright © 2018年 crystalforest. All rights reserved.
//

import UIKit

struct SideMenuCellModel {
    var icon : UIImage?
    var title : String
}

struct SideMenuHeaderModel {
    var icon : UIImage?
    var markImage : UIImage? = nil
    var title : String?
    var content : String?
    var editBtnImage : UIImage? = UIImage.init(named: "slider_menu_edit_icon")
    
}

struct SideMenuFooterModel {
    var iconA : UIImage?
    var iconB : UIImage?
    var titleA : String?
    var titleB : String?
}
