//
//  UIView+Snippet.swift
//  Snippet
//
//  Created by sunny on 2017/5/3.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import UIKit
//
//public extension UIView {
//    public var fkit: UIViewExtension {
//        get {
//            return UIViewExtension(self)
//        }
//    }
//}
//
//public class UIViewExtension {
//    var view: UIView
//
//    init(_ view: UIView) {
//        self.view = view
//    }
//
//    public var x: CGFloat {
//        get {
//            return view.x
//        }
//        set {
//            view.x = newValue
//        }
//    }
//    public var y: CGFloat {
//        get {
//            return view.y
//        }
//        set {
//            view.y = newValue
//        }
//    }
//    public var width: CGFloat {
//        get {
//            return view.width
//        }
//        set {
//            view.width = newValue
//        }
//    }
//    public var height: CGFloat {
//        get {
//            return view.height
//        }
//        set {
//            view.height = newValue
//        }
//    }
//    public var size: CGSize {
//        get {
//            return view.size
//        }
//        set {
//            view.size = newValue
//        }
//    }
//    public var centerX: CGFloat {
//        get {
//            return view.centerX
//        }
//        set {
//            view.centerX = newValue
//        }
//    }
//    public var centerY: CGFloat {
//        get {
//            return view.centerY
//        }
//        set {
//            view.centerY = newValue
//        }
//    }
//    public var top: CGFloat {
//        get {
//            return view.top
//        }
//        set {
//            view.top = newValue
//        }
//    }
//    public var bottom: CGFloat {
//        get {
//            return view.bottom
//        }
//        set {
//            view.bottom = newValue
//        }
//    }
//    public var left: CGFloat {
//        get {
//            return view.left
//        }
//        set {
//            view.left = newValue
//        }
//    }
//    public var right: CGFloat {
//        get {
//            return view.right
//        }
//        set {
//            view.right = newValue
//        }
//    }
//}

extension UIView {
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    var top: CGFloat {
        get {
            return self.y
        }
        set {
            self.y = newValue
        }
    }
    var bottom: CGFloat {
        get {
            return self.y + self.height
        }
        set {
            self.y = newValue - self.height;
        }
    }
    var left: CGFloat {
        get {
            return self.x
        }
        set {
            self.x = newValue
        }
    }
    var right: CGFloat {
        get {
            return self.x + self.width
        }
        set {
            self.x = newValue - self.width
        }
    }
}
