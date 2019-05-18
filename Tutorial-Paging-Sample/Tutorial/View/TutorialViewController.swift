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

    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var forwardButton: UIButton!
    @IBOutlet weak private var pageControl: UIPageControl!

    private let presenter = TutorialViewPresenter()

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.viewDidLoad()
    }

    @IBAction func didTapForwardButton(_ sender: UIButton) {
        presenter.didTapForwardButton()
    }

    @IBAction func didTapPageControl(_ sender: UIPageControl) {
        presenter.didTapPageControl(newPage: sender.currentPage)
    }
    
    // MARK: TutorialViewPresenterDelegate

    func setupCollectionView() {
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(InfoViewCell.nib(),
                                forCellWithReuseIdentifier: InfoViewCell.identifier)
    }

    func setupForwardButton() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.forwardButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
            self.forwardButton.layer.masksToBounds = true
            self.forwardButton.layer.cornerRadius = 22
            self.forwardButton.layer.borderWidth = 2
            self.forwardButton.layer.borderColor = UIColor.white.cgColor
        }
    }

    func receivedInfomation() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    func setPageCount(_ pageCount: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.pageControl.numberOfPages = pageCount
        }
    }

    func updateCurrentPage(_ currentPage: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.pageControl.currentPage = currentPage
        }
    }

    func pagingInfoList(_ newPage: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.scrollToItem(at: IndexPath(item: newPage, section: 0), at: .init(), animated: true)
        }
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

extension TutorialViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.infomationList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoViewCell.identifier, for: indexPath) as! InfoViewCell
        cell.setInfo(presenter.infomationList[indexPath.item])
        return cell
    }
}

extension TutorialViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let collectionView = scrollView as? UICollectionView,
            let currentInfoCell = collectionView.visibleCells.first as? InfoViewCell {
            presenter.scrollViewDidEndDecelerating(currentPageNumber: currentInfoCell.pageNumber)
        }
    }
}
