//
//  UIImage+Snippet.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/3/2.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit

extension UIImage {
    static func imageWithColor(_ color: UIColor) -> UIImage {
        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

