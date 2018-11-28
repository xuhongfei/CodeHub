//
//  CustomeCenterPresentationController.swift
//  CustomTransitionAnimation
//
//  Created by hongfei xu on 2018/11/27.
//  Copyright © 2018 xuhongfei. All rights reserved.
//

import UIKit

class CustomeCenterPresentationController: UIPresentationController {
    
    let cornerRadius: CGFloat = 16.0
    
    var presentationWrappingView: UIView? = nil
    
    var dimmingView: UIView? = nil
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        presentedViewController.modalPresentationStyle = .custom
    }
    
    override var presentedView: UIView? {
        return self.presentationWrappingView
    }
    
}

extension CustomeCenterPresentationController {
    override func presentationTransitionWillBegin() {
        let presentationWrapperView = UIView(frame: frameOfPresentedViewInContainerView)
        presentationWrapperView.layer.shadowOpacity = 0.44
        presentationWrapperView.layer.shadowRadius = 13
        presentationWrapperView.layer.shadowOffset = CGSize(width: 0, height: 0)
        /// 在重写父类的presentedView方法中，返回了self.presentationWrappingView，这个方法表示需要添加动画效果的视图
        /// 这里对self.presentationWrappingView赋值，从后面的代码可以看到这个视图处于视图层级的最上层
        self.presentationWrappingView = presentationWrapperView
        
        let presentationRoundedCornerView = UIView(frame:
            presentationWrapperView.bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)))
        presentationRoundedCornerView.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight, UIView.AutoresizingMask.flexibleWidth]
        presentationRoundedCornerView.layer.cornerRadius = cornerRadius
        presentationRoundedCornerView.layer.masksToBounds = true
        
        let presentedViewControllerWrapperView = UIView(frame: presentationRoundedCornerView.bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)))
        presentedViewControllerWrapperView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        let presentedView = super.presentedView
        presentedView?.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        presentedView?.frame = presentationWrapperView.bounds
        
        /*
         // presentationWrapperView              <- 添加阴影效果
         //   |- presentationRoundedCornerView   <- 添加圆角效果 (masksToBounds)
         //        |- presentedViewControllerWrapperView
         //             |- presentedView (presentedViewController.view)
         */
        presentedViewControllerWrapperView.addSubview(presentedView!)
        presentationRoundedCornerView.addSubview(presentedViewControllerWrapperView)
        presentationWrapperView.addSubview(presentationRoundedCornerView)
        
        /// 背景
        let dimmingView = UIView(frame: (self.containerView?.bounds)!)
        dimmingView.backgroundColor = UIColor.black
        dimmingView.isOpaque = false
        dimmingView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dimmingViewtapped(sender:))))
        self.dimmingView = dimmingView
        self.containerView?.addSubview(dimmingView)
        
        let transitionCoordinator = self.presentingViewController.transitionCoordinator
        self.dimmingView?.alpha = 0
        transitionCoordinator?.animate(alongsideTransition: { (context) in
            self.dimmingView?.alpha = 0.5
        }, completion: nil)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            self.presentationWrappingView = nil
            self.dimmingView = nil
        }
    }
    
    override func dismissalTransitionWillBegin() {
        let transitionCoordinator = self.presentingViewController.transitionCoordinator
        transitionCoordinator?.animate(alongsideTransition: { (context) in
            self.dimmingView?.alpha = 0.0
        }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            self.presentationWrappingView = nil
            self.dimmingView = nil
        }
    }
    
}

extension CustomeCenterPresentationController {
    @objc
    fileprivate func dimmingViewtapped(sender: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true, completion: nil)
    }
}

extension CustomeCenterPresentationController {
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        
        if let container = container as? UIViewController, container == self.presentedViewController {
            self.containerView?.setNeedsLayout()
        }
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        if let container = container as? UIViewController, container == self.presentedViewController {
            return container.preferredContentSize
        } else {
            return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        get {
//            let containerViewBounds = containerView?.bounds
//            let presentedViewContentSize = size(forChildContentContainer: presentedViewController, withParentContainerSize: (containerViewBounds?.size)!)
//            let presentedViewControllerFrame = CGRect(x: containerViewBounds!.origin.x, y: containerViewBounds!.maxY - presentedViewContentSize.height, width: (containerViewBounds?.size.width)!, height: presentedViewContentSize.height)
//            return presentedViewControllerFrame
            
            let containerViewBounds = containerView?.bounds
            let presentedViewContentSize = size(forChildContentContainer: presentedViewController, withParentContainerSize: (containerViewBounds?.size)!)
            let presentedViewControllerFrame = CGRect(x: (containerViewBounds!.width - presentedViewContentSize.width) * 0.5, y: (containerViewBounds!.height - presentedViewContentSize.height) * 0.5 , width:presentedViewContentSize.width , height: presentedViewContentSize.height)
            return presentedViewControllerFrame
        }
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        self.dimmingView?.frame = (self.containerView?.bounds)!
        self.presentationWrappingView?.frame = self.frameOfPresentedViewInContainerView
    }
}

extension CustomeCenterPresentationController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomePresentationAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomePresentationAnimator()
    }
}
