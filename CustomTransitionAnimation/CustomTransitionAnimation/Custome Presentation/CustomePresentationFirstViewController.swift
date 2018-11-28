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
    
    lazy var customePresentationThirdVC = CustomePresentationThirdViewController()
    lazy var customeCenterPresentationC = CustomeCenterPresentationController(presentedViewController: customePresentationThirdVC, presenting: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customePresentationSecondVC.transitioningDelegate = customePresentationC
        customePresentationThirdVC.transitioningDelegate = customeCenterPresentationC
        
        setup()
    }
    

    fileprivate func setup() {
        
        title = "自定义动画"
        view.backgroundColor = UIColor.lightGray
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "menu", style: .plain, target: self, action: #selector(back))
        
        let button = UIButton(type: .custom)
        button.setTitle("Action 1", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.backgroundColor = UIColor.groupTableViewBackground
        button.addTarget(self, action: #selector(animationButtonDidClicked), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.width.equalTo(100)
            maker.height.equalTo(32)
        }
        
        let button2 = UIButton(type: .custom)
        button2.setTitle("Action 2", for: .normal)
        button2.setTitleColor(UIColor.orange, for: .normal)
        button2.backgroundColor = UIColor.groupTableViewBackground
        button2.addTarget(self, action: #selector(animationButton2DidClicked), for: .touchUpInside)
        view.addSubview(button2)
        button2.snp.makeConstraints { (maker) in
            maker.top.equalTo(button.snp.bottom).offset(24)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(100)
            maker.height.equalTo(32)
        }
    }
}

extension CustomePresentationFirstViewController {
    @objc fileprivate func animationButtonDidClicked() {
        present(customePresentationSecondVC, animated: true, completion: nil)
    }
    
    @objc fileprivate func animationButton2DidClicked() {
        present(customePresentationThirdVC, animated: true, completion: nil)
    }
    
    @objc fileprivate func back() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
