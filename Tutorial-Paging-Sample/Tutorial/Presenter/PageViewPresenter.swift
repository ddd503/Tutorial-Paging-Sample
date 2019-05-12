//
//  PageViewPresenter.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/11.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import Foundation

protocol PageViewPresenterDelegate: class {
    func prepared(infoViewControllers: [InfoViewController])
}

final class PageViewPresenter {

    weak var delegate: PageViewPresenterDelegate?
    private var infoViewControllers = [InfoViewController]()

    // MARK: Lifecycle
    func viewDidLoad() {
        prepareInfoViewControllers()
    }

    func afterViewController(currentVC: InfoViewController?) -> InfoViewController? {
        guard let currentVC = currentVC else { return nil }
        return (infoViewControllers.count > currentVC.pageNumber) ? infoViewControllers[currentVC.pageNumber] : nil
    }

    func beforeViewController(currentVC: InfoViewController?) -> InfoViewController? {
        guard let currentVC = currentVC else { return nil }
        return (currentVC.pageNumber > 1) ? infoViewControllers[currentVC.pageNumber - 2] : nil
    }

    // MARK: Private
    private func prepareInfoViewControllers() {
        let infomation = TutorialDataStore.requestTutorialInfo()

        guard !infomation.isEmpty else { return }

        infomation.forEach {
            infoViewControllers.append(InfoViewController(info: $0))
        }
        delegate?.prepared(infoViewControllers: infoViewControllers)
    }

}
