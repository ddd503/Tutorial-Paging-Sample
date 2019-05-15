//
//  TutorialViewPresenter.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/11.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import Foundation

protocol TutorialViewPresenterDelegate: class {
    func setup()
    func didSetCurrentPage(_ newPage: Int)
    func scrollInfoList(_ newPage: Int)
    func updateButtonTitle(_ title: String)
    func closeTutorialView()
}

final class TutorialViewPresenter {

    weak var delegate: TutorialViewPresenterDelegate?
    private var allPageCount = 0
    private var currentPage = 0
    private var currentButtonTitle = "次へ"

    func viewDidLoad() {
        delegate?.setup()
        delegate?.updateButtonTitle(currentButtonTitle)
    }

    func receivedAllPageCount(_ allPageCount: Int) {
        self.allPageCount = allPageCount
    }

    // スクロールによるページ遷移
    func setCurrentPage(page: Int) {
        currentPage = page
        delegate?.didSetCurrentPage(page)
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

    private func isLastPage(newPage: Int) -> Bool {
        return newPage > allPageCount - 1
    }

    private func updateCurrentPage(newPage: Int) {
        if isLastPage(newPage: newPage) {
            delegate?.closeTutorialView()
        } else {
            delegate?.scrollInfoList(newPage)
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
