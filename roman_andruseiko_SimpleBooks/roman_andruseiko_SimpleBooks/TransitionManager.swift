//
//  TransitionManager.swift
//  roman_andruseiko_SimpleBooks
//
//  Created by Roman Andruseiko on 10/24/16.
//  Copyright © 2016 SimpleBooks. All rights reserved.
//

import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning  {
    
    var presenting = true
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        let π : CGFloat = CGFloat(M_PI)
        
        let offScreenRight = CGAffineTransform(rotationAngle: -π/2)
        let offScreenLeft = CGAffineTransform(rotationAngle: π/2)
        
        toView.transform = self.presenting ? offScreenRight : offScreenLeft
        
        toView.layer.anchorPoint = CGPoint(x:0, y:0)
        fromView.layer.anchorPoint = CGPoint(x:0, y:0)
        
        toView.layer.position = CGPoint(x:0, y:0)
        fromView.layer.position = CGPoint(x:0, y:0)
        
        container.addSubview(toView)
        container.addSubview(fromView)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: [], animations: {
            
            fromView.transform = self.presenting ? offScreenLeft : offScreenRight
            toView.transform = CGAffineTransform.identity
            
            }, completion: { finished in
                
                transitionContext.completeTransition(true)
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.75
    }
}
