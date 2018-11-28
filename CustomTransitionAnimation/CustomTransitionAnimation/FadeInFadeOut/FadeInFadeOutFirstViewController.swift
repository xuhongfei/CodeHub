//
//  FadeInFadeOutFirstViewController.swift
//  CustomTransitionAnimation
//
//  Created by hongfei xu on 2018/11/22.
//  Copyright © 2018 xuhongfei. All rights reserved.
//

import UIKit
import SnapKit

class FadeInFadeOutFirstViewController: UIViewController {

    lazy var fadeInFadeOutSecondVC = FadeInFadeOutSecondViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "淡入淡出"
        view.backgroundColor = UIColor.lightGray
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "menu", style: .plain, target: self, action: #selector(back))
        
        setup()
        
        fadeInFadeOutSecondVC.modalPresentationStyle = .fullScreen
        fadeInFadeOutSecondVC.transitioningDelegate = self
    }
    
    @objc
    fileprivate func back() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setup() {
        
        let button = UIButton(type: .custom)
        button.setTitle("Action", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.backgroundColor = UIColor.groupTableViewBackground
        button.addTarget(self, action: #selector(fromAction), for: .touchUpInside)
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
    fileprivate func fromAction() {
        present(fadeInFadeOutSecondVC, animated: true, completion: nil)
    }

}

extension FadeInFadeOutFirstViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HalfWaySpringAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CrossDissolveAnimator()
    }
}
