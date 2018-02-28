//
//  UITextView+Snippet.swift
//  More
//
//  Created by sunny on 2017/11/16.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import UIKit

extension UITextView {
    
    /// Scroll to the bottom of text view
    public func scrollToBottom() {
        let range = NSMakeRange((text as NSString).length - 1, 1)
        scrollRangeToVisible(range)
        
    }
    
    /// Scroll to the top of text view
    public func scrollToTop() {
        let range = NSMakeRange(0, 1)
        scrollRangeToVisible(range)
    }
}
