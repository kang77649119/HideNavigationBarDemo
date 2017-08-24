//
//  SecondVC.swift
//  HideNavigationBarDemo
//
//  Created by 也许、 on 2017/8/18.
//  Copyright © 2017年 也许、. All rights reserved.
//

import UIKit

let screenW = UIScreen.main.bounds.width
let screenH = UIScreen.main.bounds.height
private let cellId = "cellId"

class SecondVC: UIViewController {
    
    let oriHeight:CGFloat = 200
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var headerView: UIView!
    
    // 图片高度约束
    @IBOutlet weak var imgHeightCons: NSLayoutConstraint!
    
    lazy var titleView:UILabel = {
        let label = UILabel()
        label.text = "测试导航栏标题"
        label.textColor = UIColor.yellow
        label.alpha = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.titleView = titleView
        self.navigationController?.navigationItem.titleView = titleView
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
}

extension SecondVC : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = "测试表格\(indexPath.row)"
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 计算偏移
        let offset = oriHeight + scrollView.contentOffset.y
        var height = oriHeight - offset
        if height < 64 {
            height = 64
        }
        self.imgHeightCons.constant = height
        
        // 根据偏移量,计算出等比例透明度,设置导航栏
        var alpha = offset / (oriHeight - 64)
        if alpha > 0.99 {
            alpha = 1.0
        }
        titleView.alpha = alpha
        let alphaColor = UIColor(white: 50, alpha: alpha)
        let bgImage = UIImage.imageWithColor(color: alphaColor)
        self.navigationController?.navigationBar.setBackgroundImage(bgImage, for: .default)
        
    }
    
}



















