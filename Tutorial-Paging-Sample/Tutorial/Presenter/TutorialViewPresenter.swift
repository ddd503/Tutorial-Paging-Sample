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
    func updatedCurrentPage(_ newPage: Int)
    func updateButtonTitle(_ title: String)
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
        updatCurrentPage(newPage: (allPageCount > currentPage) ? currentPage + 1 : allPageCount)
    }

    // ページコントロールによるページ遷移
    func didTapPageControl(newPage: Int) {
        // ページコントロールページコントロールは0を含むため1足す
        updatCurrentPage(newPage: newPage + 1)
    }

    private func updatCurrentPage(newPage: Int) {
        currentPage = newPage
        delegate?.updatedCurrentPage(currentPage)
        updateButtonTitleIfNeeded()
    }

    private func updateButtonTitleIfNeeded() {
        let title = (allPageCount > currentPage) ? "次へ" : "さあ！始めよう！"
        if title != currentButtonTitle {
            delegate?.updateButtonTitle(title)
            currentButtonTitle = title
        }
    }

}
