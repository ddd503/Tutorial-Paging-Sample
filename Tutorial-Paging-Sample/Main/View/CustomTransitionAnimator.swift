//
//  CustomTransitionAnimator.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/15.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

protocol CustomTransitionAnimatorOutputs: class {
    func setSubviewsIsHidden(_ isHidden: Bool)
    func finishedTransition(_ isFinish: Bool)
}

class CustomTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    weak var view: CustomTransitionAnimatorOutputs!
    private let duration: TimeInterval

    init(view: CustomTransitionAnimatorOutputs, duration: TimeInterval) {
        self.view = view
        self.duration = duration
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let containerView = transitionContext.containerView

        guard let transitionContextFromView = transitionContext.view(forKey: .from),
            let transitionContextToView = transitionContext.view(forKey: .to) else {
                transitionContext.completeTransition(true)
                return
        }

        containerView.insertSubview(transitionContextToView, belowSubview: transitionContextFromView)

        UIView.animate(withDuration: duration, animations: {
            transitionContextFromView.alpha = 0
        }) { [weak self] (_) in
            transitionContextFromView.removeFromSuperview()
            self?.view.setSubviewsIsHidden(false)
            self?.view.finishedTransition(true)
            transitionContext.completeTransition(true)
        }
        
    }
}
