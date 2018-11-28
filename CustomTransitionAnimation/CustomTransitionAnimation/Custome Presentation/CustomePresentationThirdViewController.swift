//
//  CustomePresentationThirdViewController.swift
//  CustomTransitionAnimation
//
//  Created by hongfei xu on 2018/11/28.
//  Copyright © 2018 xuhongfei. All rights reserved.
//

import UIKit

class CustomePresentationThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        setup()
    }
    

    fileprivate func setup() {
        
        view.backgroundColor = UIColor.purple
        
        self.preferredContentSize = CGSize(width: 240, height: 270)
        
    }
    

}
