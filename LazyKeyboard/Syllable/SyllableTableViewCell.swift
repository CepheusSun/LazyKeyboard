//
//  HomeTableViewCell.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/4/17.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit

class SyllableTableViewCell: UITableViewCell, NibReuse {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    var model: Syllable! {
        didSet {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6;
            let attributeString = NSMutableAttributedString(string: model.content)
            
            model.alias.ifSome {
                let alias = NSAttributedString(string: "(别名:\($0))", attributes: [NSAttributedStringKey.foregroundColor: C.themeGreen])
                attributeString.append(alias)
            }
            attributeString.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle], range:NSRange.init(location: 0, length: attributeString.length))
            
            contentLabel.attributedText = attributeString;
            typeLabel.text = model.type
        }
    }
    
}
