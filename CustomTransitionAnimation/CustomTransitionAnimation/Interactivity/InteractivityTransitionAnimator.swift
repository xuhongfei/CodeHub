//
//  InteractivityTransitionAnimator.swift
//  CustomTransitionAnimation
//
//  Created by hongfei xu on 2018/11/27.
//  Copyright © 2018 xuhongfei. All rights reserved.
//

import UIKit

class InteractivityTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    let targetEdge: UIRectEdge
    
    init(targetEdge: UIRectEdge) {
        self.targetEdge = targetEdge
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView
        
        let fromV = transitionContext.view(forKey: .from)
        let toV = transitionContext.view(forKey: .to)
        
        // 判断当前未present还是dismiss
        let isPresenting = (toVC?.presentingViewController == fromVC)
        let fromFrame = transitionContext.initialFrame(for: fromVC!)
        let toFrame = transitionContext.finalFrame(for: toVC!)
        
        // offset结构体用于计算toView的位置
        let offset: CGVector
        switch self.targetEdge {
        case UIRectEdge.top:    offset = CGVector(dx: 0, dy: 1)
        case UIRectEdge.bottom: offset = CGVector(dx: 0, dy: -1)
        case UIRectEdge.left:   offset = CGVector(dx: 1, dy: 0)
        case UIRectEdge.right:  offset = CGVector(dx: -1, dy: 0)
        default:
            fatalError("error")
        }
        
        if isPresenting {
            fromV?.frame = fromFrame
            toV?.frame = toFrame.offsetBy(dx: toFrame.size.width * offset.dx * -1, dy: toFrame.size.height * offset.dy * -1)
            containerView.addSubview(toV!)
        } else {
            fromV?.frame = fromFrame
            toV?.frame = toFrame
            containerView.insertSubview(toV!, belowSubview: fromV!)
        }
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            if isPresenting {
                toV?.frame = toFrame
            } else {
                fromV?.frame = fromFrame.offsetBy(dx: fromFrame.size.width * offset.dx, dy: fromFrame.size.height * offset.dy)
            }
        }) { (finished) in
            let wasCancelled = transitionContext.transitionWasCancelled
            if wasCancelled {
                toV?.removeFromSuperview()
            }
            transitionContext.completeTransition(!wasCancelled)
        }
    }
}
