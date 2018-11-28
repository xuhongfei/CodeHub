//
//  ViewController.swift
//  CustomTransitionAnimation
//
//  Created by hongfei xu on 2018/11/22.
//  Copyright © 2018 xuhongfei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = "自定义转场动画"
    }

    @IBAction func fadeInFadeOut(_ sender: Any) {
        present(UINavigationController(rootViewController: FadeInFadeOutFirstViewController()), animated: true, completion: nil)
    }
    
    @IBAction func interactive(_ sender: Any) {
        present(UINavigationController(rootViewController: InteractivityFirstViewController()), animated: true, completion: nil)
    }
    
    @IBAction func custom(_ sender: Any) {
        present(UINavigationController(rootViewController: CustomePresentationFirstViewController()), animated: true, completion: nil)
    }
    
}

