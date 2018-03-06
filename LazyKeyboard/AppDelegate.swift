//
//  AppDelegate.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/2/28.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 解决导航栏返回的时候底部一坨黑色的问题
        self.window?.backgroundColor = .white
        
//        Cloud.shared.addToCloud()
        
//        Cloud.shared.queryFromCloud()
        return true
    }

}

