//
//  InteractivityFirstViewController.swift
//  CustomTransitionAnimation
//
//  Created by hongfei xu on 2018/11/27.
//  Copyright © 2018 xuhongfei. All rights reserved.
//

import UIKit

class InteractivityFirstViewController: UIViewController {

    lazy var interactivitySecondVC: InteractivitySecondViewController = InteractivitySecondViewController()
    lazy var customTransitionDelegate = InteractivityTransitionDelegate()
    lazy var interactiveTransitionRecognizer: UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(interactiveTransitionRecognizerAction(sender:)))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        interactiveTransitionRecognizer.edges = .right
        view.addGestureRecognizer(interactiveTransitionRecognizer)
        
        interactivitySecondVC.transitioningDelegate = customTransitionDelegate
        interactivitySecondVC.modalPresentationStyle = .fullScreen
        
        setup()
    }
    
    fileprivate func setup() {
        
        title = "交互式动画"
        view.backgroundColor = UIColor.lightGray
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "menu", style: .plain, target: self, action: #selector(back))
        
        let button = UIButton(type: .custom)
        button.setTitle("Action", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.backgroundColor = UIColor.groupTableViewBackground
        button.addTarget(self, action: #selector(animationButtonDidClicked(sender:)), for: .touchUpInside)
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
    
    @objc
    fileprivate func back() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
}

extension InteractivityFirstViewController {
    @objc
    func interactiveTransitionRecognizerAction(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .began {
            animationButtonDidClicked(sender: sender)
        }
    }
}

extension InteractivityFirstViewController {
    @objc
    func animationButtonDidClicked(sender: AnyObject) {
        if sender.isKind(of: UIGestureRecognizer.self) {
            customTransitionDelegate.gestureRecognizer = interactiveTransitionRecognizer
        } else {
            customTransitionDelegate.gestureRecognizer = nil
        }
        
        customTransitionDelegate.targetEdge = .right
        present(interactivitySecondVC, animated: true, completion: nil)
    }
}
