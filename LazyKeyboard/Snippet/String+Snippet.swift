//
//  String+Snippet.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/3/10.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit


// MARK: - 工具 String 计算高度和宽度
public extension String {
    
    public func height(for font: UIFont!, width: CGFloat!) -> CGFloat!{
        let size = CGSize(width: width, height: 900)
        let dic = NSDictionary.init(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        let strSize = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey: AnyObject], context: nil)
        return strSize.height
    }
    
    public func width(for font: UIFont!, height: CGFloat!) -> CGFloat!{
        let size = CGSize(width: 900, height: height)
        let dic = NSDictionary.init(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        let strSize = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey: AnyObject], context: nil)
        return strSize.width
    }
}

