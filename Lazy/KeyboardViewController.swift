//
//  KeyboardViewController.swift
//  Lazy
//
//  Created by sunny on 2018/2/28.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonHeight = 40
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .custom)
        
        self.nextKeyboardButton.setImage(#imageLiteral(resourceName: "keyboard_earth"), for: .normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        self.nextKeyboardButton.backgroundColor = .darkGray
        self.nextKeyboardButton.layer.cornerRadius = 5;
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.anchor(
            top: nil, leading: view.leadingAnchor,
            bottom: view.bottomAnchor, trailing: nil,
            padding: UIEdgeInsetsMake(0, 10, 5, 0),
            size: CGSize(width: 70, height: buttonHeight))

        let returnButton = UIButton(type: .custom)
        returnButton.setTitle("return", for: .normal)
        returnButton.sizeToFit()
        returnButton.translatesAutoresizingMaskIntoConstraints = false
        returnButton.backgroundColor = .darkGray
        returnButton.layer.cornerRadius = 5;
        self.view.addSubview(returnButton)

        returnButton.anchor(
            top: nil, leading: nil,
            bottom: view.bottomAnchor,
            trailing: self.view.trailingAnchor,
            padding: UIEdgeInsetsMake(0, 0, 5, 10),
            size: CGSize(width: 80, height: buttonHeight))
        
        let spaceButton = UIButton(type: .custom)
        spaceButton.setTitle("space", for: .normal)
        spaceButton.sizeToFit()
        spaceButton.translatesAutoresizingMaskIntoConstraints = false
        spaceButton.backgroundColor = .darkGray
        spaceButton.layer.cornerRadius = 5;
        self.view.addSubview(spaceButton)
        
        spaceButton.anchor(
            top: self.nextKeyboardButton.topAnchor,
            leading: self.nextKeyboardButton.trailingAnchor,
            bottom: view.bottomAnchor, trailing: returnButton.leadingAnchor,
            padding: UIEdgeInsetsMake(0, 5, 5, 5),
            size: .zero)
    
        let deleteButton = UIButton(type: .custom)
        deleteButton.setTitle("delete", for: .normal)
        deleteButton.sizeToFit()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.backgroundColor = .darkGray
        deleteButton.layer.cornerRadius = 5;
        self.view.addSubview(deleteButton)
        
        deleteButton.anchor(
            top: self.view.topAnchor,
            leading: nil,
            bottom: nil, trailing: returnButton.trailingAnchor,
            padding: UIEdgeInsetsMake(10, 5, 10, 0),
            size: CGSize(width: 80, height: buttonHeight))
        
        
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

}
