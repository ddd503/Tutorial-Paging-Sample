//
//  ViewController.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/11.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ViewControllerPresenterOutputs, CustomTransitionAnimatorOutputs {

    @IBOutlet weak private var label: UILabel!
    @IBOutlet weak private var tutorialButton: UIButton!
    @IBOutlet weak private var waitingView: UIView!
    private var presenter: ViewControllerPresenter!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }

    func inject(presenter: ViewControllerPresenter) {
        self.presenter = presenter
    }

    @IBAction func didTapTutorialButton(_ sender: UIButton) {
        presenter.didTapTutorialButton()
    }

    // MARK: ViewControllerPresenterOutputs

    func presentTutorialViewController() {
        guard let tutorialVC = TutorialViewController.make() else {
            print("TutorialViewControllerの取得に失敗")
            return
        }
        waitingView.isHidden = true
        tutorialVC.transitioningDelegate = self
        tutorialVC.inject(presenter: TutorialViewPresenter(view: tutorialVC))
        present(tutorialVC, animated: true)
    }

    // MARK: CustomTransitionAnimatorOutputs

    func setSubviewsIsHidden(_ isHidden: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.label.isHidden = isHidden
            self?.tutorialButton.isHidden = isHidden
        }
    }

    func finishedTransition(_ isFinish: Bool) {
        presenter.setIsNotFinishTutorial(isFinish)
    }

}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presenter.animationControllerForDismissed()
    }
}
