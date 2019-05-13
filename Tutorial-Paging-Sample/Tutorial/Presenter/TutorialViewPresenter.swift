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
}

final class TutorialViewPresenter {

    weak var delegate: TutorialViewPresenterDelegate?
    private var allPageCount = 0
    private var currentPage = 0

    func viewDidLoad() {
        delegate?.setup()
    }

    func receivedAllPageCount(_ allPageCount: Int) {
        self.allPageCount = allPageCount
    }

    func setCurrentPage(page: Int) {
        currentPage = page
        delegate?.didSetCurrentPage(page)
    }

    func didTapForwardButton() {
        print("\(currentPage)")
    }

}
