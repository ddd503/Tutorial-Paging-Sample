//
//  PageViewController.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/11.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, PageViewPresenterDelegate {

    private let presenter = PageViewPresenter()
    private var infoViewControllers = [InfoViewController]()
    private var infoList = [Infomation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.viewDidLoad()
    }

    func prepared(infoViewControllers: [InfoViewController]) {
        self.infoViewControllers = infoViewControllers
        setViewControllers(infoViewControllers,
                           direction: .forward,
                           animated: false,
                           completion: nil)
    }

}

extension PageViewController: UIPageViewControllerDataSource {

    // LeftPaging
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return presenter.afterViewController()
    }

    // RightPaging
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return presenter.beforeViewController()
    }

}
