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
    
    var kvos: [NSKeyValueObservation] = []
    
    typealias PageCellCallBack = (Int) -> ()
    
    var callBack: PageCellCallBack?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        buttonItems.forEach { [unowned self] in
            let kvo = $0.observe(\.isHighlighted) { (obj, changed) in
                if obj.isHighlighted {
                    
                    obj.backgroundColor = UIColor.colorWithHexString("B1B1B1")
                    
                } else {
                    obj.backgroundColor = .white
                }
            }
            self.kvos.append(kvo)
        }
    }
    
    var keylist: [KeyButton]! {
        didSet {
            buttonItems.forEach({$0.isHidden = true})
            
            for (index, key) in keylist.enumerated() {
                
                self.buttonItems[index].isHidden = false
                
                switch key.type {
                case .character(let letter):
                     self.buttonItems[index].setTitle(letter, for: .normal)
                default:
                    self.buttonItems[index].setTitle("", for: .normal)
                }
            }
        }
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        let index = self.buttonItems.index(of: sender)
        if index.hasSome {
            self.callBack.ifSome {
                $0(index!)
            }
        }
    }
    
    
}
