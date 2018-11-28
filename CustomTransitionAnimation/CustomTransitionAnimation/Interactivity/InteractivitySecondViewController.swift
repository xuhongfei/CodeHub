//
//  InteractivitySecondViewController.swift
//  CustomTransitionAnimation
//
//  Created by hongfei xu on 2018/11/27.
//  Copyright © 2018 xuhongfei. All rights reserved.
//

import UIKit

class InteractivitySecondViewController: UIViewController {

    lazy var interactiveTransitionRecognizer: UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(interactiveTransitionRecognizerAction(sender:)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactiveTransitionRecognizer.edges = .left
        view.addGestureRecognizer(interactiveTransitionRecognizer)
        
        setup()
    }
    
    fileprivate func setup() {
        
        view.backgroundColor = UIColor.purple
        
        let button = UIButton(type: .custom)
        button.setTitle("Action", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.backgroundColor = UIColor.groupTableViewBackground
        button.addTarget(self, action: #selector(buttonDidClicked(sender:)), for: .touchUpInside)
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

}

extension InteractivitySecondViewController {
    @objc
    func interactiveTransitionRecognizerAction(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .began {
            buttonDidClicked(sender: sender)
        }
    }
}

extension InteractivitySecondViewController {
    @objc
    func buttonDidClicked(sender: AnyObject) {
        if let transitionDelegate = transitioningDelegate as? InteractivityTransitionDelegate {
            if sender.isKind(of: UIGestureRecognizer.self) {
                transitionDelegate.gestureRecognizer = interactiveTransitionRecognizer
            } else {
                transitionDelegate.gestureRecognizer = nil
            }
            transitionDelegate.targetEdge = .left
        }
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
