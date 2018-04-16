//
//  KeyboardView.swift
//  Lazy
//
//  Created by sunny on 2018/3/1.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit
import SnapKit

class KeyboardView: UIView {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var spaceButton: UIButton!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var selectorScrollView: UIScrollView!
    @IBOutlet weak var atButton: UIButton!
    
    var section: [Syllable] = [] {
        didSet {
//            self.pages = 1//section[self.typeIndex].pages
            self.setupSelector()
        }
    }
    
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
    
    var items: [UIButton] = []
    func setupSelector() {
        selectorScrollView.subviews.forEach({$0.removeFromSuperview()})
        items = []
        let array = []//section.map({ $0.title })
        for (index, title) in array.enumerated() {
            
            let button = makeButton()
            items.append(button)
            button.setTitle(title, for: .normal)
            selectorScrollView.addSubview(button)
            if index == typeIndex {
                button.isSelected = true
                button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            }
            let width = title.width(for: UIFont.systemFont(ofSize: 16), height: 20) + 10
            button.snp.makeConstraints({ (make) in
                if index == 0 {
                    make.left.equalTo(selectorScrollView)
                } else {
                    make.left.equalTo(items[index - 1].snp.right)
                }
                make.width.equalTo(width)
                make.top.equalTo(selectorScrollView)
                make.height.equalTo(selectorScrollView)
                if index == array.count - 1 {
                    make.right.equalTo(selectorScrollView)
                }
            })
        }
        
    }
    
    private func makeButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitleColor(UIColor.colorWithRGB(160, g: 160, b: 160), for: UIControlState.normal)
        button.setTitleColor(UIColor.colorWithRGB(51, g: 51, b: 51), for: UIControlState.selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return button
    }
    
    var typeIndex: Int = 0
    @objc func buttonAction(_ sender: UIButton) {
        
        items.forEach({
            $0.isSelected = false
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        })
        sender.isSelected = true
        sender.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        typeIndex = items.index(of: sender).or(0)!
        collectionView.reloadData()
        collectionView.contentOffset = .zero
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
        collectionView.register(cellType: PageCell.self)

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
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PageCell.self)
        let key = pages[indexPath.row]
        cell.keylist = key
        cell.contentView.backgroundColor = backgroundColor
        cell.callBack = { [unowned self] in
            let key = self.pages[indexPath.row][$0]
            self.callBack.ifSome {
                $0(key)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width - 90
        return CGSize(width: width, height: 170)
    }

}
