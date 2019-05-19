//
//  ViewController.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/11.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ViewControllerPresenterDelegate {

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
        self.presenter.delegate = self
    }

    func setSubviews(isHidden: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.label.isHidden = isHidden
            self?.tutorialButton.isHidden = isHidden
        }
    }

    func switchFlagForTutorial(isNotFinishTutorial: Bool) {
        presenter.isNotFinishTutorial = isNotFinishTutorial
    }

    @IBAction func didTapTutorialButton(_ sender: UIButton) {
        presenter.didTapTutorialButton()
    }

    // MARK: ViewControllerPresenterDelegate

    func presentTutorialViewController() {
        guard let tutorialVC = TutorialViewController.make() else {
            print("TutorialViewControllerの取得に失敗")
            return
        }
        waitingView.isHidden = true
        tutorialVC.transitioningDelegate = self
        tutorialVC.inject(presenter: TutorialViewPresenter())
        present(tutorialVC, animated: true)
    }

}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomTransitionAnimator(duration: 1, fromVC: self)
    }
}
