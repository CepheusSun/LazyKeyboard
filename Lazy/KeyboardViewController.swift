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
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        return cv
    }()
    

    override func updateViewConstraints() {
        super.updateViewConstraints()
        let buttonHeight = 40
        self.nextKeyboardButton.anchor(
            top: nil, leading: view.leadingAnchor,
            bottom: view.bottomAnchor, trailing: nil,
            padding: UIEdgeInsetsMake(0, 10, 5, 0),
            size: CGSize(width: 70, height: buttonHeight))
        
        self.returnKeyboardButton.anchor(
            top: nil, leading: nil,
            bottom: view.bottomAnchor,
            trailing: self.view.trailingAnchor,
            padding: UIEdgeInsetsMake(0, 0, 5, 10),
            size: CGSize(width: 80, height: buttonHeight))
        
        self.spaceKeyboardButton.anchor(
            top: self.nextKeyboardButton.topAnchor,
            leading: self.nextKeyboardButton.trailingAnchor,
            bottom: view.bottomAnchor, trailing: self.returnKeyboardButton.leadingAnchor,
            padding: UIEdgeInsetsMake(0, 5, 5, 5),
            size: .zero)
        
        self.deleteKeyboardButton.anchor(
            top: self.view.topAnchor,
            leading: nil,
            bottom: nil, trailing: self.returnKeyboardButton.trailingAnchor,
            padding: UIEdgeInsetsMake(10, 5, 10, 0),
            size: CGSize(width: 80, height: buttonHeight))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Perform custom UI setup here
        nextKeyboardButton.setImage(#imageLiteral(resourceName: "keyboard_earth"), for: .normal)
        view.addSubview(nextKeyboardButton)
        
        returnKeyboardButton.setTitle("return", for: .normal)
        view.addSubview(returnKeyboardButton)

        spaceKeyboardButton.setTitle("space", for: .normal)
        view.addSubview(spaceKeyboardButton)
        
        deleteKeyboardButton.setTitle("delete", for: .normal)
        view.addSubview(deleteKeyboardButton)
        updateViewConstraints()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    
    
    private func makeKeyboardButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.sizeToFit()
        button.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 5;
        return button
    }

}

extension KeyboardViewController: UICollectionViewDelegateFlowLayout {
    
    
}

extension KeyboardViewController: UICollectionViewDataSource {
    
}

















