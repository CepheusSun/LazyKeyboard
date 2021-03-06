//
//  MoreTableViewCell.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/2/28.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//

import UIKit

class MoreTableViewCell: UITableViewCell, Reuse {

    var item: MoreItem! {
        didSet {
            self.textLabel?.text = item.title
            self.accessoryType = .none
            if item.showMore.absolute {
                self.accessoryType = .disclosureIndicator
            }
            self.detailTextLabel?.text = item.message.or("")
            if let isOn = item.switchState {
                self.switch.isHidden = false
                self.switch.isOn = isOn
            }
        }
    }
    
    lazy var `switch`: UISwitch = {
        let s = UISwitch()
        contentView.addSubview(s)
        s.translatesAutoresizingMaskIntoConstraints = false
        s.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true;
        s.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14).isActive = true
        s.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        return s
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
        self.switch.isHidden = true
    }
    
    var switchValueChangedCallback: ((Bool) -> ())?
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        item.switchState = sender.isOn
        switchValueChangedCallback.ifSome {[unowned sender] in
            $0(sender.isOn)
        }
    }
    
}
