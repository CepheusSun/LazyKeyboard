//
//  PremiumController.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/3/2.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit

class PremiumController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "成为Premium版用户"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(dismissSelf))
    }

    @objc func dismissSelf() {
        navigationController?.dismiss(animated: true, completion: nil)
    }



}
