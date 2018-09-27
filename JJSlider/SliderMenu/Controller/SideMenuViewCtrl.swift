//
//  SideMenuViewCtrl.swift
//  Schaeffler
//
//  Created by crystalforest on 2018/9/6.
//  Copyright © 2018年 crystalforest. All rights reserved.
//

import UIKit
import SnapKit

class SideMenuViewCtrl: BaseViewCtrl {
    
    private var models = [SideMenuCellModel]()
    private var headerModel = SideMenuHeaderModel.init()
    private lazy var footerModel : SideMenuFooterModel = {
        var model = SideMenuFooterModel.init()
        model.iconA = UIImage.init(named: "slider_menu_settings_icon")
        model.titleA = "设置"
        model.iconB = UIImage.init(named: "slider_menu_settings_icon")
        model.titleB = "登出"
        return model
    }()
    
    private var backView : UIView = {
        let backView = UIView.init()
        backView.backgroundColor = UIColor.white
        return backView
    }()
    
    private lazy var header : SideMenuHeader = {
        var header = SideMenuHeader.loadFromNib()
        header.delegate = self
        return header
    }()
    private var footer = SideMenuFooter.loadFromNib()
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "SideMenuCell", bundle: nil), forCellReuseIdentifier:SideMenuCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        configData()
        tableView.reloadData()
        header.model = headerModel
        footer.model = footerModel
    }
    
}

private extension SideMenuViewCtrl {
    
    func initUI() {
        
        view.backgroundColor = UIColor.blue
        
        view.addSubview(backView)
        
        backView.addSubview(tableView)

        backView.addSubview(header)
        
        backView.addSubview(footer)
        
        layoutUI()
        
    }
    
    func layoutUI() {
        
        backView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(SliderConfig.kMainPageDistance * 0.5)
            make.top.height.equalToSuperview()
            make.width.equalTo(SliderConfig.kSideExposedWidth)
        }
        
        header.snp.makeConstraints { (make) -> Void in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(SideMenuHeader.height)
        }
        
        footer.snp.makeConstraints { (make) -> Void in
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
            make.bottom.equalToSuperview().offset(-GlobalDefine.safeAreaBottomHeight)
        }
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(header.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(footer.snp.top)
        }
        
    }
    
    func configData() {
        // cell
        var cellModel : SideMenuCellModel
        for index in 1...20 {
            if index % 2 == 0 {
                cellModel = SideMenuCellModel(icon: UIImage.init(named: "slider_menu_settings_icon"), title: "test")
            } else {
                cellModel = SideMenuCellModel(icon: nil, title: "test")
            }
            models.append(cellModel)
        }
        
        // header
        headerModel.icon = UIImage.init(named: "slider_menu_portrait_icon")
        headerModel.title = "Free"
        headerModel.content = "crtstal"
        
        
    }
    
}

extension SideMenuViewCtrl : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.identifier) as! SideMenuCell
        cell.model = models[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension SideMenuViewCtrl : SideMenuHeaderDelegate {
    func headerEditBtnClick() {
        print("headerEditBtnClick")
    }
    
    func headerIconClick() {
        print("headerIconClick")
    }
}

