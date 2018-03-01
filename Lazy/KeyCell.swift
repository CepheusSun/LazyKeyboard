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
}
