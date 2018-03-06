//
//  PageCell.swift
//  Lazy
//
//  Created by sunny on 2018/3/6.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit
import Reusable

class PageCell: UICollectionViewCell, NibReusable {

    @IBOutlet var buttonItems: [UIButton]!
    
    
    var keylist: [KeyButton]! {
        didSet {
            buttonItems.forEach({$0.isHidden = true})
            
            for (index, key) in keylist.enumerated() {
                
                self.buttonItems[index].isHidden = false
                
                switch key.type {
                case .character(let letter):
                     self.buttonItems[index].setTitle(letter, for: .normal)
                default: label.text = ""
                }
                
            }
        }
    }
}
