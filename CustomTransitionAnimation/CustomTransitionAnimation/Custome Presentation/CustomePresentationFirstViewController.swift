//
//  CustomePresentationFirstViewController.swift
//  CustomTransitionAnimation
//
//  Created by hongfei xu on 2018/11/27.
//  Copyright © 2018 xuhongfei. All rights reserved.
//

import UIKit

class CustomePresentationFirstViewController: UIViewController {

    lazy var customePresentationSecondVC = CustomePresentationSecondViewController()
    lazy var customePresentationC = CustomePresentationController(presentedViewController: customePresentationSecondVC, presenting: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customePresentationSecondVC.transitioningDelegate = customePresentationC
        
        setup()
    }
    

    fileprivate func setup() {
        
        title = "自定义动画"
        view.backgroundColor = UIColor.lightGray
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "menu", style: .plain, target: self, action: #selector(back))
        
        let button = UIButton(type: .custom)
        button.setTitle("Action", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.backgroundColor = UIColor.groupTableViewBackground
        button.addTarget(self, action: #selector(animationButtonDidClicked), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.width.equalTo(60)
            maker.height.equalTo(32)
        }
        
        let label = UILabel()
        label.text = "from"
        label.textColor = UIColor.orange
        label.font = UIFont.systemFont(ofSize: 17)
        view.addSubview(label)
        label.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(button.snp.top).offset(-24)
        }
    }
}

extension CustomePresentationFirstViewController {
    @objc fileprivate func animationButtonDidClicked() {
        present(customePresentationSecondVC, animated: true, completion: nil)
    }
    
    @objc fileprivate func back() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
