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

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!

    private let presenter = TutorialViewPresenter()
    private var infoListVC: InfoListViewController?

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let infoListVC = segue.destination as? InfoListViewController, segue.identifier == "toInfoListViewController" {
            infoListVC.delegate = self
            self.infoListVC = infoListVC
        }
    }

    @IBAction func didTapForwardButton(_ sender: UIButton) {
        presenter.didTapForwardButton()
    }

    @IBAction func didTapPageControl(_ sender: UIPageControl) {
        presenter.didTapPageControl(newPage: sender.currentPage)
    }
    
    // MARK: TutorialViewPresenterDelegate

    func setup() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.forwardButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
            self.forwardButton.layer.masksToBounds = true
            self.forwardButton.layer.cornerRadius = 22
            self.forwardButton.layer.borderWidth = 2
            self.forwardButton.layer.borderColor = UIColor.white.cgColor
            self.pageControl.hidesForSinglePage = true
        }
    }

    func didSetCurrentPage(_ newPage: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.pageControl.currentPage = newPage
        }
    }

    func scrollInfoList(_ newPage: Int) {
        infoListVC?.setPage(newPage)
    }

    func updateButtonTitle(_ title: String) {
        DispatchQueue.main.async { [weak self] in
            self?.forwardButton.setTitle(title, for: .normal)
        }
    }

    func closeTutorialView() {
        self.dismiss(animated: true, completion: nil)
    }

}

extension TutorialViewController: InfoListViewControllerDelegate {
    func preparedInfoList(infoCount: Int) {
        presenter.receivedAllPageCount(infoCount)
        DispatchQueue.main.async { [weak self] in
            self?.pageControl.numberOfPages = infoCount
        }
    }

    func infoListViewDidEndDecelerating(currentPageNumber: Int) {
        presenter.setCurrentPage(page: currentPageNumber)
    }
}
