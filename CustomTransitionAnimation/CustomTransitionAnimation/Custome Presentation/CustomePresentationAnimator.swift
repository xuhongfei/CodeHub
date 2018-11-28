//
//  CustomePresentationAnimator.swift
//  CustomTransitionAnimation
//
//  Created by hongfei xu on 2018/11/28.
//  Copyright © 2018 xuhongfei. All rights reserved.
//

import UIKit

class CustomePresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if let isAnimated = transitionContext?.isAnimated {
            return isAnimated ? 0.35 : 0.0
        }
        
        return 0.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView
        
        let fromV = transitionContext.view(forKey: .from)
        let toV = transitionContext.view(forKey: .to)
        let isPresenting = toVC?.presentingViewController == fromVC
        
        var fromViewFinalFrame = transitionContext.finalFrame(for: fromVC!)
        var toViewInitialFrame = transitionContext.initialFrame(for: toVC!)
        let toViewFinalFrame = transitionContext.finalFrame(for: toVC!)
        
        if let toV = toV {
            containerView.addSubview(toV)
        }
        
        if isPresenting {
//            toViewInitialFrame.origin = CGPoint(x: containerView.bounds.minX, y: containerView.bounds.maxY)
            
            toViewInitialFrame.origin = CGPoint(x: (containerView.frame.width - toViewFinalFrame.size.width) * 0.5, y: containerView.bounds.maxY)
            toViewInitialFrame.size = toViewFinalFrame.size
            toV?.frame = toViewInitialFrame
        } else {
//            fromViewFinalFrame = fromV!.frame.offsetBy(dx: 0, dy: fromV!.frame.height)
            fromViewFinalFrame = fromV!.frame.offsetBy(dx: 0, dy: (containerView.frame.height - fromV!.frame.height) * 0.5 + fromV!.frame.height)
        }
        
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            if isPresenting {
                toV?.frame = toViewFinalFrame
            } else {
                fromV?.frame = fromViewFinalFrame
            }
        }) { (finished) in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
        
    }
}
