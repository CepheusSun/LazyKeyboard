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
    
    var key: KeyButton! {
        didSet {
            switch key.type {
            case .character(let letter):
                if letter.alias.hasSome {
                    label.text = letter.alias!
//                    label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
                    label.textColor = .red
                } else {
                    label.text = letter.content
//                    label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                    label.textColor = .black
                }
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
