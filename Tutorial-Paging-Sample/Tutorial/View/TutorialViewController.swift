//
//  TutorialViewController.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/11.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController, TutorialViewPresenterDelegate {

    class func make() -> TutorialViewController? {
        let storyBoard = UIStoryboard(name: String(describing: TutorialViewController.self), bundle: .main)
        return storyBoard.instantiateInitialViewController() as? TutorialViewController
    }

    @IBOutlet weak var forwardButton: UIButton!

    private let presenter = TutorialViewPresenter()

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.viewDidLoad()
    }

    func setup() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.forwardButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
            self.forwardButton.layer.masksToBounds = true
            self.forwardButton.layer.cornerRadius = 22
            self.forwardButton.layer.borderWidth = 2
            self.forwardButton.layer.borderColor = UIColor.white.cgColor
        }
    }

    @IBAction func didTapForwardButton(_ sender: UIButton) {
        print("tap")
    }

}
