//
//  UIColor+Extension.swift
//  HideNavigationBarDemo
//
//  Created by 也许、 on 2017/8/24.
//  Copyright © 2017年 也许、. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func imageWithColor(color:UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let ref = UIGraphicsGetCurrentContext()
        ref!.setFillColor(color.cgColor)
        ref!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
}
