//
//  TutorialViewPresenter.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/11.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import Foundation

protocol TutorialViewPresenterDelegate: class {
    init()
    func setupCollectionView()
    func setupForwardButton()
    func receivedInfomation()
    func setPageCount(_ pageCount: Int)
    func updateCurrentPage(_ currentPage: Int)
    func pagingInfoList(_ newPage: Int)
    func updateButtonTitle(_ title: String)
    func closeTutorialView()
}

final class TutorialViewPresenter {

    weak var delegate: TutorialViewPresenterDelegate?
    var infomationList = [Infomation]()
    private var currentButtonTitle = "次へ"
    private var currentPage = 0 {
        didSet {
            delegate?.updateCurrentPage(currentPage)
        }
    }

    func viewDidLoad() {
        delegate?.setupCollectionView()
        delegate?.setupForwardButton()
        infomationList = TutorialDataStore.requestTutorialInfo()
        guard !infomationList.isEmpty else {
            // エラー用のセルを出すもあり
            fatalError("ローカルにチュートリアル情報がありません")
        }
        delegate?.receivedInfomation()
        delegate?.setPageCount(infomationList.count)
        updateButtonTitleIfNeeded()
    }

    // ボタンによるページ遷移
    func didTapForwardButton() {
        updateCurrentPage(newPage: currentPage + 1)
    }

    // ページコントロールによるページ遷移
    func didTapPageControl(newPage: Int) {
        updateCurrentPage(newPage: newPage)
    }

    // スクロールによるページ遷移
    func scrollViewDidEndDecelerating(currentPageNumber: Int) {
        currentPage = currentPageNumber
        delegate?.updateCurrentPage(currentPageNumber)
        updateButtonTitleIfNeeded()
    }

    private func isLastPage(newPage: Int) -> Bool {
        return newPage > infomationList.count - 1
    }

    private func updateCurrentPage(newPage: Int) {
        if isLastPage(newPage: newPage) {
            delegate?.closeTutorialView()
        } else {
            delegate?.pagingInfoList(newPage)
            currentPage = newPage
        }
        updateButtonTitleIfNeeded()
    }

    private func updateButtonTitleIfNeeded() {
        let title = isLastPage(newPage: currentPage + 1) ? "さあ！始めよう！" : "次へ"
        if title != currentButtonTitle {
            delegate?.updateButtonTitle(title)
            currentButtonTitle = title
        }
    }

}
