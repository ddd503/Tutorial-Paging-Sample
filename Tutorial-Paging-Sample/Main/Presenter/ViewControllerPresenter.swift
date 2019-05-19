//
//  ViewControllerPresenter.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/11.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import Foundation
import UIKit

protocol ViewControllerPresenterInputs {
    func viewDidAppear()
    func didTapTutorialButton()
    func setIsNotFinishTutorial(_ isNotFinish: Bool)
    func animationControllerForDismissed() -> CustomTransitionAnimator
}

protocol ViewControllerPresenterOutputs: class {
    func presentTutorialViewController()
}

final class ViewControllerPresenter: ViewControllerPresenterInputs {

    weak var view: ViewControllerPresenterOutputs!
    weak var transitionView: CustomTransitionAnimatorOutputs!
    private var isFinishTutorial = false

    init(view: ViewControllerPresenterOutputs, customTransitionView: CustomTransitionAnimatorOutputs) {
        self.view = view
        self.transitionView = customTransitionView
    }

    func viewDidAppear() {
        if !isFinishTutorial {
            view.presentTutorialViewController()
        }
    }

    func didTapTutorialButton() {
        view.presentTutorialViewController()
    }

    func setIsNotFinishTutorial(_ isFinish: Bool) {
        isFinishTutorial = isFinish
    }

    func animationControllerForDismissed() -> CustomTransitionAnimator {
        return CustomTransitionAnimator(view: transitionView, duration: 1)
    }
    
}
