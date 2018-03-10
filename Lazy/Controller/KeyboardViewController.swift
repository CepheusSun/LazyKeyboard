//
//  KeyboardViewController.swift
//  Lazy
//
//  Created by sunny on 2018/2/28.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit
import AudioToolbox

class KeyboardViewController: UIInputViewController {

    private var viewModel = KeyboardViewModel()
    
//    var heightConstraint: NSLayoutConstraint!
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.inputView?.addConstraint(self.heightConstraint)
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.heightConstraint = NSLayoutConstraint(
//            item:self.inputView ?? <#default value#>,
//            attribute:.Height,
//            relatedBy:.Equal,
//            toItem:nil,
//            attribute:.NotAnAttribute,
//            multiplier:0.0,
//            constant:500)
        
        _ = view.height
        let keyboard = KeyboardView.create(with: self)
        keyboard.pages = viewModel.pages
        view.addSubview(keyboard)
        
        var height: CGFloat = 216
        if UIScreen.main.bounds.height == 736 {
           height = 226
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            keyboard.translatesAutoresizingMaskIntoConstraints = false
            keyboard.fillSuperviewAdaptSafeArea()
            keyboard.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        
        keyboard.callBack = {[unowned self] in
            
            switch $0.type {
            case .character(let letter):
                self.textDocumentProxy.insertText(letter)
                self.autoSend()
                self.playKeySound()
            case .backspace:
                self.textDocumentProxy.deleteBackward()
                self.playKeySound()
            case .space:
                self.textDocumentProxy.insertText(" ")
                self.playKeySound()
            case .return:
                self.textDocumentProxy.insertText("\n")
                self.playKeySound()
            case .at:
                self.textDocumentProxy.insertText("@")
                self.playKeySound()
            case .keyboardChange: break
            case .spaceLongPress:
                self.openMainApp()
            }
        }
        
        var str = ""
        switch self.textDocumentProxy.returnKeyType! {
        case .go: str = "Go"
        case .send: str = "发送"
        case .search: str = "搜索"
        case .google: str = "Google"
        case .done: str = "完成"
        case .next: str = "下一步"
        case .join: str = "加入"
        case .continue: str = "Continue"
        case .default: str = "完成"
        case.emergencyCall: str = "紧急呼叫"
        case .route: str = "下一步"
        case .yahoo: str = "Yahoo"
        }
        keyboard.setReturnKeyTitle(str)
    
        
        let darkMode = { () -> Bool in
            let proxy = self.textDocumentProxy
            return proxy.keyboardAppearance == UIKeyboardAppearance.dark
        }()

        if darkMode {
            keyboard.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        } else {
            keyboard.backgroundColor = UIColor.colorWithRGB(209, g: 213, b: 218)
        }

    }

    func playKeySound() {
        if viewModel.setting.isPressShake {
            DispatchQueue.global(qos: .default).async(execute: {
                // 按键音
                AudioServicesPlaySystemSound(1104)
//                UIDevice.current.playInputClick()
            })
        }
    }
    
    func autoSend() {
        if viewModel.setting.isSendAfterSelected {
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                self.textDocumentProxy.insertText("\n")
            })
        }
    }

    func openMainApp() {
        if viewModel.setting.isLongPressSpaceToMainApp {
            playKeySound()
            OpenMainKit.openMainApp(self, extensionContext: self.extensionContext)
        }
    }

}




