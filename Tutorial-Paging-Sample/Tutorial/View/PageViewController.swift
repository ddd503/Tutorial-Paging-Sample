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

    func setup() {
        dataSource = self
    }

    func prepared(infoViewControllers: [InfoViewController]) {
        self.infoViewControllers = infoViewControllers
        guard !self.infoViewControllers.isEmpty else { return }
        setViewControllers([self.infoViewControllers[0]], direction: .forward, animated: false, completion: nil)
    }

}

extension PageViewController: UIPageViewControllerDataSource {

    // LeftPaging
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return presenter.afterViewController(currentVC: viewController as? InfoViewController)
    }

    // RightPaging
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return presenter.beforeViewController(currentVC: viewController as? InfoViewController)
    }

}
