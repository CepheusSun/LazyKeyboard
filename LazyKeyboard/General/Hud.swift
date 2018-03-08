//
//  Hud.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/3/8.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import Foundation
import PKHUD

extension UIViewController {
    
    func show(_ message: String, loading: Bool = false) {
        if loading {
            HUD.show(.systemActivity)
        } else {
            HUD.flash(.label(message), delay: 1)
            
        }
    }
    
    func hideHud() {
        HUD.hide()
    }
    
}

