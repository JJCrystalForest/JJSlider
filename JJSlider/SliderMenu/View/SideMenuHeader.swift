//
//  SideMenuHeader.swift
//  Schaeffler
//
//  Created by crystalforest on 2018/9/6.
//  Copyright © 2018年 crystalforest. All rights reserved.
//

import UIKit

@objc protocol SideMenuHeaderDelegate {
    @objc optional func headerEditBtnClick()
    @objc optional func headerIconClick()
}

class SideMenuHeader: UIView {

    @IBOutlet weak var markIV: UIImageView!
    @IBOutlet weak var iconIV: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var contentLb: UILabel!
    
    weak var delegate : SideMenuHeaderDelegate?
    private lazy var tapGesture : UITapGestureRecognizer = {
        var tap = UITapGestureRecognizer.init(target: self, action: #selector(self.iconClick))
        return tap
    }()
    
    static let height = GlobalDefine.isIphoneX() ? 130 : 120
    
    var model : SideMenuHeaderModel? {
        didSet {
            iconIV.image = model?.icon
            markIV.image = model?.markImage
            editBtn.setImage(model?.editBtnImage, for: .normal)
            titleLb.text = model?.title
            contentLb.text = model?.content
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        editBtn.addTarget(self, action: #selector(self.editBtnClick), for: .touchUpInside)
        iconIV.isUserInteractionEnabled = true
        iconIV.addGestureRecognizer(tapGesture)
    }

}

extension SideMenuHeader {
    
    static func loadFromNib() -> SideMenuHeader {
        return Bundle.main.loadNibNamed("SideMenuHeader", owner: nil, options: nil)?[0] as! SideMenuHeader
    }
    
    @objc private func editBtnClick() {
        guard let delegate = self.delegate else { return }
        delegate.headerEditBtnClick?()
    }
    
    @objc private func iconClick() {
        guard let delegate = self.delegate else { return }
        delegate.headerIconClick?()
    }
}
