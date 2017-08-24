//
//  ThirdVC.swift
//  HideNavigationBarDemo
//
//  Created by 也许、 on 2017/8/24.
//  Copyright © 2017年 也许、. All rights reserved.
//

import UIKit

private let cellId = "cellId"
class ThirdVC: UIViewController {
    
    let headerViewHeight:CGFloat = 200
    var heightCons:NSLayoutConstraint?
    
    lazy var titleView:UILabel = {
        let label:UILabel = UILabel()
        label.textColor = UIColor.white
        label.alpha = 0
        label.text = "测试标题"
        return label
    }()
    
    lazy var headerImageView:UIImageView = {
        let headerImageView:UIImageView = UIImageView()
        headerImageView.image = UIImage(contentsOfFile: Bundle.main.path(forResource: "test2.jpg", ofType: nil)!)
        headerImageView.contentMode = .scaleToFill
        return headerImageView
    }()
    
    lazy var headerView:UIView = {
        let headerView:UIView = UIView()
        return headerView
    }()
    
    lazy var tableView:UITableView = {
        let tableView:UITableView = UITableView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: screenW, height: screenH)))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

extension ThirdVC {
    
    func setupUI() {
        
        // 消除自动添加的边距
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        // 设置导航栏标题
        self.navigationItem.titleView = self.titleView
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // 添加表格、头部视图
        tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0)
        self.view.addSubview(tableView)
        
        // 设置头部视图约束
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(headerView)
        let topCons = NSLayoutConstraint(item: headerView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0)
        let leftCons = NSLayoutConstraint(item: headerView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0)
        let rightCons = NSLayoutConstraint(item: headerView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0)
        heightCons = NSLayoutConstraint(item: headerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 200)
        self.view.addConstraints([topCons, leftCons, rightCons, heightCons!])
        
        // 设置头部视图中的图片空间约束
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(headerImageView)
        let imgTopCons = NSLayoutConstraint(item: headerImageView, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .top, multiplier: 1.0, constant: 0)
        let imgLeftCons = NSLayoutConstraint(item: headerImageView, attribute: .left, relatedBy: .equal, toItem: headerView, attribute: .left, multiplier: 1.0, constant: 0)
        let imgRightCons = NSLayoutConstraint(item: headerImageView, attribute: .right, relatedBy: .equal, toItem: headerView, attribute: .right, multiplier: 1.0, constant: 0)
        let imgHeightCons = NSLayoutConstraint(item: headerImageView, attribute: .height, relatedBy: .equal, toItem: headerView, attribute: .height, multiplier: 1.0, constant: 0)
        self.view.addConstraints([imgTopCons, imgLeftCons, imgRightCons, imgHeightCons])
        
    }
    
}

extension ThirdVC : UITableViewDataSource, UITableViewDelegate {
    
    // 表格滑动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 获取偏移量 headerViewHeight 图片视图的高度
        let offset = headerViewHeight + scrollView.contentOffset.y
        // 计算距离导航栏还有多少高度
        var height = headerViewHeight - offset
        // 当高度小于导航栏高度时,设置图片高度与导航栏等高
        if height < 64 {
            height = 64
        }
        // 根据计算出的高度,修改图片视图高度的约束
        self.heightCons?.constant = height
        
        // 根据偏移量计算alpha 不包含导航栏高度，所以要减去64
        var alpha = offset / (headerViewHeight - 64)
        if alpha > 0.99 {
            alpha = 1
        }
        
        // 设置导航栏栏和标题栏的透明度
        let bgColor = UIColor(white: 1, alpha: alpha)
        let bgImage = UIImage.imageWithColor(color: bgColor)
        self.titleView.alpha = alpha
        self.navigationController?.navigationBar.setBackgroundImage(bgImage, for: .default)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = "单元格数据\(indexPath.row)"
        return cell
    }
    
}
