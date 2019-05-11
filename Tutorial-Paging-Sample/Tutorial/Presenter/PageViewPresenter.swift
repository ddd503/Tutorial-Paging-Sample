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
    private var infomation = [Infomation]()

    // MARK: Lifecycle
    func viewDidLoad() {
        prepareInfoViewControllers()
    }

    func afterViewController() -> InfoViewController? {
        return nil
    }

    func beforeViewController() -> InfoViewController? {
        return nil
    }

    // MARK: Private
    private func prepareInfoViewControllers() {
        infomation = TutorialDataStore.requestTutorialInfo()

        guard !infomation.isEmpty else { return }

        var infoViewControllers = [InfoViewController]()
        infomation.forEach {
            infoViewControllers.append(InfoViewController(info: $0))
        }
    }



}
