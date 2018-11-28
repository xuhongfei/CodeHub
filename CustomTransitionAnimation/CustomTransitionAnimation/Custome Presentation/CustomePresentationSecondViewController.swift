//
//  CustomePresentationSecondViewController.swift
//  CustomTransitionAnimation
//
//  Created by hongfei xu on 2018/11/27.
//  Copyright © 2018 xuhongfei. All rights reserved.
//

import UIKit

class CustomePresentationSecondViewController: UIViewController {
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.addTarget(self, action: #selector(sliderValueChange(sender:)), for: .valueChanged)
        view.addSubview(slider)
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        updatePreferredContentSizeWithTraitCollection(traitCollection: self.traitCollection)
    }
    

    fileprivate func setup() {
        
        view.backgroundColor = UIColor.purple
        
        let button = UIButton(type: .custom)
        button.setTitle("Action", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.backgroundColor = UIColor.groupTableViewBackground
        button.addTarget(self, action: #selector(buttonDidClicked), for: .touchUpInside)
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
        
        slider.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-12)
            maker.width.equalTo(240)
        }
        
    }
    
    fileprivate func updatePreferredContentSizeWithTraitCollection(traitCollection: UITraitCollection) {
        self.preferredContentSize = CGSize(width: view.bounds.width, height: traitCollection.verticalSizeClass == .compact ? 270: 420)
        
        slider.maximumValue = Float(self.preferredContentSize.height)
        slider.minimumValue = 220
        slider.value = slider.maximumValue
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        updatePreferredContentSizeWithTraitCollection(traitCollection: traitCollection)
    }
}

extension CustomePresentationSecondViewController {
    
    @objc
    fileprivate func buttonDidClicked() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc
    fileprivate func sliderValueChange(sender: UISlider) {
        self.preferredContentSize = CGSize(width: view.bounds.width, height: CGFloat(sender.value))
    }
    
}
