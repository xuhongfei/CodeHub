//
//  CrossDissolveAnimator.swift
//  CustomTransitionAnimation
//
//  Created by hongfei xu on 2018/11/27.
//  Copyright © 2018 xuhongfei. All rights reserved.
//

import UIKit

class CrossDissolveAnimator: NSObject {

}

extension CrossDissolveAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView
        
        let fromV = transitionContext.view(forKey: .from)
        let toV = transitionContext.view(forKey: .to)
        
        
        fromV?.frame = transitionContext.initialFrame(for: fromVC!)
        toV?.frame = transitionContext.finalFrame(for: toVC!)
        
        fromV?.alpha = 1.0
        toV?.alpha = 0.0
        
        containerView.addSubview(toV!)
        
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            fromV?.alpha = 0.0
            toV?.alpha = 1.0
        }) { (finished) in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }
}
