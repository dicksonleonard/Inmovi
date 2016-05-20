//
//  PresentationAnimator.swift
//  Inmovi
//
//  Created by Alfonse MBP 00 on 5/18/16.
//  Copyright © 2016 Alvonse. All rights reserved.
//

import UIKit

class PresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var openingFrame: CGRect?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()
        
        let animationDuration = self .transitionDuration(transitionContext)
        
        // add blurred background to the view
        let fromViewFrame = fromViewController.view.frame
        
        UIGraphicsBeginImageContext(fromViewFrame.size)
        fromViewController.view.drawViewHierarchyInRect(fromViewFrame, afterScreenUpdates: true)
        let snapshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let snapshotView = toViewController.view.resizableSnapshotViewFromRect(toViewController.view.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
        snapshotView.frame = openingFrame!
        snapshotView.alpha = 0.0
        containerView!.addSubview(snapshotView)
        
        toViewController.view.alpha = 0.0
        containerView!.addSubview(toViewController.view)
        
//        UIView.animateWithDuration(animationDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 20.0, options: UIViewAnimationOptions.CurveEaseIn,
//            animations: { () -> Void in
//                snapshotView.frame = fromViewController.view.frame
//            }, completion: { (finished) -> Void in
//                snapshotView.removeFromSuperview()
//                toViewController.view.alpha = 1.0
//                
//                transitionContext.completeTransition(finished)
//        })
        
        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
            snapshotView.alpha = 1.0
            snapshotView.frame = fromViewController.view.frame

            }) { (finished) -> Void in
                snapshotView.removeFromSuperview()
                toViewController.view.alpha = 1.0
                transitionContext.completeTransition(finished)
//                snapshotView.removeFromSuperview()
//                fromViewController.view.removeFromSuperview()
//                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}
