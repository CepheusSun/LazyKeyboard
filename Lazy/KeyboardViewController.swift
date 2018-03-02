//
//  KeyboardViewController.swift
//  Lazy
//
//  Created by sunny on 2018/2/28.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit

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
            case .backspace:
                self.textDocumentProxy.deleteBackward()
            case .space:
                self.textDocumentProxy.insertText(" ")
            case .return:
                self.textDocumentProxy.insertText("\n")
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

    
    override func textDidChange(_ textInput: UITextInput?) {
        
    }
}




