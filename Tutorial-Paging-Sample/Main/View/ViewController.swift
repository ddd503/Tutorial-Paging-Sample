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
    private let presenter = ViewControllerPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }

    func setSubviews(isHidden: Bool) {
        label.isHidden = isHidden
        tutorialButton.isHidden = isHidden
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
        present(tutorialVC, animated: true)
    }

}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomTransitionAnimator(duration: 1, fromVC: self)
    }
}
