//
//  CustomTransitionAnimator.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/15.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class CustomTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    let duration: TimeInterval
    weak var fromVC: UIViewController?

    init(duration: TimeInterval, fromVC: UIViewController) {
        self.duration = duration
        self.fromVC = fromVC
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let containerView = transitionContext.containerView

        guard let transitionContextFromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }

        guard let transitionContextToView = transitionContext.view(forKey: .to) else { return }

        containerView.insertSubview(transitionContextToView, belowSubview: transitionContextFromView)

        UIView.animate(withDuration: duration, animations: {
            transitionContextFromView.alpha = 0
        }) { [weak self] (_) in
            transitionContextFromView.removeFromSuperview()
            if let vc = self?.fromVC as? ViewController {
                vc.setSubviews(isHidden: false)
                vc.switchFlagForTutorial(isNotFinishTutorial: false)
            }
        }
        
    }
}
