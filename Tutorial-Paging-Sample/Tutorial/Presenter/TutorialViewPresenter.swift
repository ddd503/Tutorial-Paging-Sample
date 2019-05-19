//
//  TutorialViewPresenter.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/11.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import Foundation

protocol TutorialViewPresenterInputs {
    func viewDidLoad()
    func didTapForwardButton()
    func didTapPageControl(newPage: Int)
    func scrollViewDidEndDecelerating(currentPageNumber: Int)
}

protocol TutorialViewPresenterOutputs: class {
    func setupCollectionView()
    func setupForwardButton()
    func receivedInfomation()
    func setPageCount(_ pageCount: Int)
    func updateCurrentPage(_ currentPage: Int)
    func pagingInfoList(_ newPage: Int)
    func updateButtonTitle(_ title: String)
    func closeTutorialView()
}

final class TutorialViewPresenter: TutorialViewPresenterInputs {

    private weak var view: TutorialViewPresenterOutputs!
    var infomationList = [Infomation]()
    private var currentButtonTitle = "次へ"
    private var currentPage = 0 {
        didSet {
            view?.updateCurrentPage(currentPage)
        }
    }

    init(view: TutorialViewPresenterOutputs) {
        self.view = view
    }

    func viewDidLoad() {
        view.setupCollectionView()
        view.setupForwardButton()
        infomationList = TutorialDataStore.requestTutorialInfo()
        guard !infomationList.isEmpty else {
            // エラー用のセルを出すもあり
            fatalError("ローカルにチュートリアル情報がありません")
        }
        view.receivedInfomation()
        view.setPageCount(infomationList.count)
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
        view.updateCurrentPage(currentPageNumber)
        updateButtonTitleIfNeeded()
    }

    private func isLastPage(newPage: Int) -> Bool {
        return newPage > infomationList.count - 1
    }

    private func updateCurrentPage(newPage: Int) {
        if isLastPage(newPage: newPage) {
            view.closeTutorialView()
        } else {
            view.pagingInfoList(newPage)
            currentPage = newPage
        }
        updateButtonTitleIfNeeded()
    }

    private func updateButtonTitleIfNeeded() {
        let title = isLastPage(newPage: currentPage + 1) ? "さあ！始めよう！" : "次へ"
        if title != currentButtonTitle {
            view.updateButtonTitle(title)
            currentButtonTitle = title
        }
    }

}
