//
//  FadeInFadeOutSecondViewController.swift
//  CustomTransitionAnimation
//
//  Created by hongfei xu on 2018/11/22.
//  Copyright © 2018 xuhongfei. All rights reserved.
//

import UIKit

class FadeInFadeOutSecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.purple
        
        setup()
    }
    
    fileprivate func setup() {
        
        let button = UIButton(type: .custom)
        button.setTitle("Action", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.backgroundColor = UIColor.groupTableViewBackground
        button.addTarget(self, action: #selector(toAction), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.width.equalTo(60)
            maker.height.equalTo(32)
        }
        
        let label = UILabel()
        label.text = "to"
        label.textColor = UIColor.orange
        label.font = UIFont.systemFont(ofSize: 17)
        view.addSubview(label)
        label.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(button.snp.top).offset(-24)
        }
    }
    
    @objc
    fileprivate func toAction() {
        dismiss(animated: true, completion: nil)
    }
}
