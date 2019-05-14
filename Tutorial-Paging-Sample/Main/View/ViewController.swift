//
//  ViewController.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/11.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ViewControllerPresenterDelegate {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var waitingView: UIView!
    private let presenter = ViewControllerPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }

    // MARK: ViewControllerPresenterDelegate

    func presentTutorialViewController() {
        guard let tutorialVC = TutorialViewController.make() else {
            print("TutorialViewControllerの取得に失敗")
            return
        }
        waitingView.isHidden = true
        present(tutorialVC, animated: true)
    }

}

