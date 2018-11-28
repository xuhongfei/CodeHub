//
//  TransitionInteractionController.swift
//  CustomTransitionAnimation
//
//  Created by hongfei xu on 2018/11/27.
//  Copyright © 2018 xuhongfei. All rights reserved.
//

import UIKit

class TransitionInteractionController: UIPercentDrivenInteractiveTransition {
    var transitionContext: UIViewControllerContextTransitioning? = nil
    var gestureRecognizer: UIScreenEdgePanGestureRecognizer
    var edge: UIRectEdge
    
    init(gestureRecognizer: UIScreenEdgePanGestureRecognizer, edgeForDragging edge: UIRectEdge) {
        assert(edge == .top || edge == .bottom || edge == .left || edge == .right, "error.")
        
        self.gestureRecognizer = gestureRecognizer
        self.edge = edge
        
        super.init()
        self.gestureRecognizer.addTarget(self, action: #selector(gestureRecognizeDidUpdate(gestureRecignizer:)))
    }
    
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        super.startInteractiveTransition(transitionContext)
    }
    
    @objc
    fileprivate func gestureRecognizeDidUpdate(gestureRecignizer: UIScreenEdgePanGestureRecognizer) {
        switch gestureRecignizer.state {
        case .began:    break
        case .changed:  update(percentForGesture(gesture: gestureRecignizer))
        case .ended:
            if self.percentForGesture(gesture: gestureRecignizer) >= 0.5 {
                finish()
            } else {
                cancel()
            }
        default:        cancel()
        }
    }
    
    @objc
    fileprivate func percentForGesture(gesture: UIScreenEdgePanGestureRecognizer) -> CGFloat {
        if let transitionContainerView = transitionContext?.containerView {
            let locationInScourceView = gesture.location(in: transitionContainerView)
            
            let width = transitionContainerView.bounds.width
            let height = transitionContainerView.bounds.height
            
            switch self.edge {
            case UIRectEdge.right:  return (width - locationInScourceView.x) / width
            case UIRectEdge.left:   return locationInScourceView.x / width
            case UIRectEdge.bottom: return (height - locationInScourceView.y) / height
            case UIRectEdge.top:    return locationInScourceView.y / height
            default: return 0
            }
        }
        
        return 0
    }
}
