//
//  InfoListViewController.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/12.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

protocol InfoListViewControllerDelegate: class {
    func preparedInfoList(infoCount: Int)
    func infoListViewDidEndDecelerating(currentPageNumber: Int)
}

class InfoListViewController: UIViewController, InfoListViewPresenterDelegate {

    @IBOutlet weak private var collectionView: UICollectionView!

    weak var delegate: InfoListViewControllerDelegate?
    private let presenter = InfoListViewPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.viewDidLoad()
    }

    func setPage(_ page: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.scrollToItem(at: IndexPath(item: page, section: 0), at: .init(), animated: true)
        }
        delegate?.infoListViewDidEndDecelerating(currentPageNumber: page)
    }

    // MARK: InfoListViewPresenterDelegate

    func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(InfoViewCell.nib(), forCellWithReuseIdentifier: InfoViewCell.identifier)
    }

    func preparedInfoList() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
        delegate?.preparedInfoList(infoCount: presenter.infomationList.count)
    }

}

extension InfoListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.infomationList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoViewCell.identifier, for: indexPath) as! InfoViewCell
        cell.setInfo(presenter.infomationList[indexPath.item])
        return cell
    }
}

extension InfoListViewController: UICollectionViewDelegateFlowLayout {
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
            delegate?.infoListViewDidEndDecelerating(currentPageNumber: currentInfoCell.pageNumber)
        }
    }
}
