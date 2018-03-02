//
//  KeyCell.swift
//  Lazy
//
//  Created by sunny on 2018/3/1.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit
import Reusable

class KeyCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    var key: Key! {
        didSet {
            switch key.type {
            case .character(let letter):
                label.text = letter
            default:
                label.text = ""
            }
        }
    }
    
    func switchTo(hightLight: Bool) {
        if hightLight {
            bgView.backgroundColor = UIColor.colorWithHexString("B1B1B1")
        } else {
            bgView.backgroundColor = .white
        }
    }
    
}
