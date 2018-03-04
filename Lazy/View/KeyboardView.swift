//
//  KeyboardView.swift
//  Lazy
//
//  Created by sunny on 2018/3/1.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit

class KeyboardView: UIView {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var spaceButton: UIButton!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var atButton: UIButton!
    
    var pages: [[KeyButton]] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    var kvos: [NSKeyValueObservation] = []
    
    typealias KeyboardViewCallBack = (KeyButton) -> ()
    var callBack: KeyboardViewCallBack?
    
    weak var controller: UIViewController!
    
    static func create(with controller: UIViewController) -> KeyboardView {
        let keyboard = Bundle.main.loadNibNamed("KeyboardView", owner: nil, options: nil)?.first as! KeyboardView
        keyboard.controller = controller
        keyboard.setup()
        return keyboard
    }
    
    func setup() {
        
        nextButton.addTarget(controller, action: #selector(KeyboardViewController.handleInputModeList(from:with:)), for: .allTouchEvents)
    
        [nextButton, returnButton, deleteButton, atButton].forEach { [unowned self] in
            let kvo = $0?.observe(\.isHighlighted) { (obj, changed) in
                if obj.isHighlighted {
                    obj.backgroundColor = .white
                } else {
                    obj.backgroundColor = UIColor.colorWithHexString("B1B1B1")
                }
            }
            self.kvos.append(kvo!)
        }
        [spaceButton].forEach { [unowned self] in
            let kvo = $0?.observe(\.isHighlighted) { (obj, changed) in
                if !obj.isHighlighted {
                    obj.backgroundColor = .white
                } else {
                    obj.backgroundColor = UIColor.colorWithHexString("B1B1B1")
                }
            }
            self.kvos.append(kvo!)
        }
        collectionView.register(cellType: KeyCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        configBackSpaceButtonAction()
        configSpaceButtonAction()
    }
    
    func setReturnKeyTitle(_ title: String) {
        returnButton.setTitle(title, for: .normal)
    }
    
    @IBAction func sendButtonAction(_ sender: Any) {
        let key = KeyButton(KeyButton.KeyType.return)
        self.callBack.ifSome { $0(key) }
    }
    
    @IBAction func atButtonAction(_ sender: Any) {
        let key = KeyButton(KeyButton.KeyType.at)
        self.callBack.ifSome { $0(key) }
    }
    
    var backspaceDelayTimer: Timer?
    var backspaceRepeatTimer: Timer?
    let backspaceDelay: TimeInterval = 0.5
    let backspaceRepeat: TimeInterval = 0.07
    
    var spaceDelayTimer: Timer?
    let spaceDelay: TimeInterval = 1
    
}

extension KeyboardView {
    
    private func configSpaceButtonAction() {
        let cancelEvents: UIControlEvents = [UIControlEvents.touchUpInside, UIControlEvents.touchUpInside, UIControlEvents.touchDragExit, UIControlEvents.touchUpOutside, UIControlEvents.touchCancel, UIControlEvents.touchDragOutside]
        
        spaceButton.addTarget(self,
                              action: #selector(spaceDown(_:)),
                              for: .touchDown)
        spaceButton.addTarget(self,
                              action: #selector(spaceUp(_:)),
                              for: cancelEvents)
    }
    
    @objc func spaceDown(_ sender: Any) {
        
        cancelSpaceTimers()
        spaceCallback()
        
        // trigger for subsequent deletes
        self.spaceDelayTimer = Timer.scheduledTimer(timeInterval: spaceDelay, target: self, selector: #selector(spaceLongPressCallback), userInfo: nil, repeats: false)
    }
    
    @objc func spaceUp(_ sender: Any) {
        self.cancelSpaceTimers()
    }
    
    func cancelSpaceTimers() {
        spaceDelayTimer?.invalidate()
        spaceDelayTimer = nil
    }
    
    @objc func spaceCallback() {
        cancelSpaceTimers()
        
        let key = KeyButton(KeyButton.KeyType.space)
        self.callBack.ifSome { $0(key) }
    }
    
    @objc func spaceLongPressCallback() {
        cancelSpaceTimers()
        
        let key = KeyButton(KeyButton.KeyType.spaceLongPress)
        self.callBack.ifSome { $0(key) }
    }
}

extension KeyboardView {
    
    private func configBackSpaceButtonAction() {
        let cancelEvents: UIControlEvents = [UIControlEvents.touchUpInside, UIControlEvents.touchUpInside, UIControlEvents.touchDragExit, UIControlEvents.touchUpOutside, UIControlEvents.touchCancel, UIControlEvents.touchDragOutside]
        deleteButton.addTarget(self,
                              action: #selector(backspaceDown(_:)),
                              for: .touchDown)
        deleteButton.addTarget(self,
                              action: #selector(backspaceUp(_:)),
                              for: cancelEvents)
    }
    
    func cancelBackspaceTimers() {
        self.backspaceDelayTimer?.invalidate()
        self.backspaceRepeatTimer?.invalidate()
        self.backspaceDelayTimer = nil
        self.backspaceRepeatTimer = nil
    }
    
    @objc func backspaceDown(_ sender: Any) {
        
        cancelBackspaceTimers()
        backspaceCallback()
        
        // trigger for subsequent deletes
        self.backspaceDelayTimer = Timer.scheduledTimer(timeInterval: backspaceDelay - backspaceRepeat, target: self, selector: #selector(backspaceDelayCallback), userInfo: nil, repeats: false)
    }
    
    @objc func backspaceUp(_ sender: Any) {
        self.cancelBackspaceTimers()
    }
    
    @objc func backspaceDelayCallback() {
        self.backspaceDelayTimer = nil
        self.backspaceRepeatTimer = Timer.scheduledTimer(timeInterval: backspaceRepeat, target: self, selector: #selector(backspaceCallback), userInfo: nil, repeats: true)
    }
    
    @objc func backspaceCallback() {
        let key = KeyButton(KeyButton.KeyType.backspace)
        self.callBack.ifSome { $0(key) }
    }
}

extension KeyboardView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return pages[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: KeyCell.self)
        let key = pages[indexPath.section][indexPath.row]
        cell.key = key
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.width - 10) / 2 - 3, height: 39)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell: KeyCell? = collectionView.cellForItem(at: indexPath) as? KeyCell
        cell?.switchTo(hightLight: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell: KeyCell? = collectionView.cellForItem(at: indexPath) as? KeyCell
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
           cell?.switchTo(hightLight: false)
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let key = pages[indexPath.section][indexPath.row]
        self.callBack.ifSome {
            $0(key)
        }
    }
}
