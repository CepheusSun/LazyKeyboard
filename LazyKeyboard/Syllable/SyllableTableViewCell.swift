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
            let attributeString = NSAttributedString(string: model.content, attributes: [NSAttributedStringKey.paragraphStyle: paragraphStyle])
            contentLabel.attributedText = attributeString;
            typeLabel.text = model.type
        }
    }
    
}
