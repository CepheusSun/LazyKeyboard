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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let height: CGFloat = 256

        keyboard.fillSuperviewAdaptSafeArea()
        keyboard.heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    var keyboard: KeyboardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configKeyboard()
    }

    private func configKeyboard() {
        keyboard = KeyboardView.create(with: self)
        keyboard.section = viewModel.list
        view.addSubview(keyboard)
        
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
    

    private func playKeySound() {
        if viewModel.setting.isPressShake {
            DispatchQueue.global(qos: .default).async(execute: {
                // 按键音
                AudioServicesPlaySystemSound(1104)
            })
        }
    }
    
    private func autoSend() {
        if viewModel.setting.isSendAfterSelected {
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                self.textDocumentProxy.insertText("\n")
            })
        }
    }

    private func openMainApp() {
        if viewModel.setting.isLongPressSpaceToMainApp {
            playKeySound()
            OpenMainKit.openMainApp(self, extensionContext: self.extensionContext)
        }
    }
}
