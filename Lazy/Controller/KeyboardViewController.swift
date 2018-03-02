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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = view.height
        let keyboard = KeyboardView.create(with: self)
        keyboard.pages = viewModel.pages
        view.addSubview(keyboard)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            keyboard.translatesAutoresizingMaskIntoConstraints = false
            keyboard.fillSuperviewAdaptSafeArea()
            keyboard.heightAnchor.constraint(equalToConstant: 226).isActive = true
        }
        
        keyboard.callBack = {[unowned self] in
            
            switch $0.type {
            case .character(let letter):
                self.textDocumentProxy.insertText(letter)
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
            }
        }
        
        var str = ""
        switch self.textDocumentProxy.returnKeyType! {
        case .go:
            str = "Go"
        case .send:
            str = "Send"
        case .search:
            str = "Search"
        case .google:
            str = "Google"
        case .done:
            str = "Done"
        case .next:
            str = "Next"
        case .join:
            str = "Join"
        case .continue:
            str = "Continue"
        default:
            str = "Done"
        }
        keyboard.setReturnKeyTitle(str)
    
    }

    func playKeySound() {
        if viewModel.setting.isPressShake {
            DispatchQueue.global(qos: .default).async(execute: {
                // 按键音
                AudioServicesPlaySystemSound(1104)
            })
        }
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        
    }
}




