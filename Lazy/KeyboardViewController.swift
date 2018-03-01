//
//  KeyboardViewController.swift
//  Lazy
//
//  Created by sunny on 2018/2/28.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    private lazy var nextKeyboardButton: UIButton = makeKeyboardButton()
    private lazy var returnKeyboardButton: UIButton = makeKeyboardButton()
    private lazy var spaceKeyboardButton: UIButton = makeKeyboardButton()
    private lazy var deleteKeyboardButton: UIButton = makeKeyboardButton()
    private let buttonHeight: CGFloat = 40
    private var viewModel = KeyboardViewModel()
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.frame = CGRect(x: 10, y: 10, width: 300, height: 160)
        sv.backgroundColor = .red
        sv.contentOffset = CGPoint.zero
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.isPagingEnabled = true
        return sv
    }()
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        let height = view.height;
        view.translatesAutoresizingMaskIntoConstraints = false
        view.fillSuperview()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        nextKeyboardButton.anchor(
            top: nil, leading: view.leadingAnchor,
            bottom: view.bottomAnchor, trailing: nil,
            padding: UIEdgeInsetsMake(0, 10, 5, 0),
            size: CGSize(width: 70, height: buttonHeight))
        
        returnKeyboardButton.anchor(
            top: nil, leading: nil,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: UIEdgeInsetsMake(0, 0, 5, 10),
            size: CGSize(width: 80, height: buttonHeight))
        
        spaceKeyboardButton.anchor(
            top: nextKeyboardButton.topAnchor,
            leading: nextKeyboardButton.trailingAnchor,
            bottom: view.bottomAnchor,
            trailing: returnKeyboardButton.leadingAnchor,
            padding: UIEdgeInsetsMake(0, 5, 5, 5),
            size: .zero)
        
        deleteKeyboardButton.anchor(
            top: view.topAnchor,
            leading: nil, bottom: nil,
            trailing: returnKeyboardButton.trailingAnchor,
            padding: UIEdgeInsetsMake(10, 5, 10, 0),
            size: CGSize(width: 80, height: buttonHeight))
        
        scrollView.anchor(top: view.topAnchor,
                          leading: view.leadingAnchor,
                          bottom: spaceKeyboardButton.topAnchor,
                          trailing: deleteKeyboardButton.leadingAnchor,
                          padding: UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 5))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Perform custom UI setup here
        nextKeyboardButton.setTitle("🌐", for: .normal)
        view.addSubview(nextKeyboardButton)

        returnKeyboardButton.setTitle("return", for: .normal)
        view.addSubview(returnKeyboardButton)

        spaceKeyboardButton.setTitle("space", for: .normal)
        view.addSubview(spaceKeyboardButton)
        
        deleteKeyboardButton.setTitle("⌫", for: .normal)
        view.addSubview(deleteKeyboardButton)
        
        view.addSubview(scrollView)
        
        updateViewConstraints()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
}

extension KeyboardViewController {
    
    private func makeKeyboardButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.sizeToFit()
        button.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 5;
        return button
    }
}


