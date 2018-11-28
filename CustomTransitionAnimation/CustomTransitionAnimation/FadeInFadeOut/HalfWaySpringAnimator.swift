//
//  HalfWaySpringAnimator.swift
//  CustomTransitionAnimation
//
//  Created by hongfei xu on 2018/11/22.
//  Copyright © 2018 xuhongfei. All rights reserved.
//

import UIKit

class HalfWaySpringAnimator: NSObject {

}

extension HalfWaySpringAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let _ = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        
        let containerView = transitionContext.containerView
        
//        var fromView = fromVC?.view
//        var toView = toVC?.view
//        if transitionContext.responds(to: #selector("viewForKey:")) {
//        }
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)
        
        toView?.frame = CGRect(x: fromView!.frame.origin.x, y: fromView!.frame.maxY * 0.5, width: fromView!.frame.size.width, height: fromView!.frame.size.height)
        toView?.alpha = 0.0
        
        containerView.addSubview(toView!)
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: transitionDuration, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveLinear, animations: {
            toView?.alpha = 1.0
            toView?.frame = transitionContext.finalFrame(for: toVC!)
        }) { (finished) in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }
    
    
}
