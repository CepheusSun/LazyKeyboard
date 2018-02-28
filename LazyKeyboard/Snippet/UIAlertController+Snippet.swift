//
//  UIAlertController+Snippet.swift
//  Snippet
//
//  Created by sunny on 2017/11/12.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import UIKit

typealias AlertActionHandler = ((UIAlertAction) -> Void)

extension UIAlertControllerStyle {
    
    func controller(title: String?,
                    message: String?,
                    actions: [UIAlertAction]
        ) -> UIAlertController {
            
            let _controller = UIAlertController(
                title: title,
                message: message,
                preferredStyle: self
            )
            actions.forEach{ _controller.addAction($0) }
            return _controller
    }
}

extension String {
    
    func alertAction(
        style: UIAlertActionStyle = .default,
        handler: AlertActionHandler? = nil
        ) -> UIAlertAction {
        return UIAlertAction(
            title: self,
            style: style,
            handler: handler
        )
    }
}
