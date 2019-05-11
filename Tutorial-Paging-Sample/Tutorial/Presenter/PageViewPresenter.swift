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

    func viewDidLoad() {
        
    }

    func afterViewController() -> InfoViewController? {
        return nil
    }

    func beforeViewController() -> InfoViewController? {
        return nil
    }

}
