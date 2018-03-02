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
    
    var pages: [[Key]] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    typealias KeyboardViewCallBack = (Key) -> ()
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
        
        nextButton.setImage(UIImage.imageWithColor(UIColor.colorWithHexString("B1B1B1")), for: .normal)
        nextButton.setImage(UIImage.imageWithColor(.white), for: .highlighted)

        collectionView.register(cellType: KeyCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setReturnKeyTitle(_ title: String) {
        returnButton.setTitle(title, for: .normal)
    }
    
    @IBAction func sendButtonAction(_ sender: Any) {
        let key = Key(Key.KeyType.return)
        self.callBack.ifSome { $0(key) }
    }
    
    @IBAction func spaceButtonAction(_ sender: Any) {
        let key = Key(Key.KeyType.space)
        self.callBack.ifSome { $0(key) }
    }
    
    @IBAction func backSpaceButtonAction(_ sender: Any) {
        let key = Key(Key.KeyType.backspace)
        self.callBack.ifSome { $0(key) }
    }
    
    @IBAction func atButtonAction(_ sender: Any) {
        let key = Key(Key.KeyType.at)
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