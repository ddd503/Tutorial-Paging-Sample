//
//  InfoListViewController.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/12.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class InfoListViewController: UIViewController, InfoListViewPresenterDelegate {

    @IBOutlet weak private var scrollView: UIScrollView!
    private let presenter = InfoListViewPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.viewDidLoad()
    }

    func preparedInfoList(_ infoList: [Infomation]) {
        infoList.enumerated().forEach { [weak self] (offset, element) in
            guard let self = self else { return }
            let infoView = InfoView.make(frame: CGRect(x: CGFloat(Int(self.view.bounds.size.width) * offset),
                                                       y: 0,
                                                       width: self.view.bounds.size.width,
                                                       height: self.view.bounds.size.height),
                                         pageNumber: element.pageNumber)
            self.scrollView.addSubview(infoView)
            self.scrollView.contentSize = CGSize(width: max(scrollView.contentSize.width, infoView.frame.maxX),
                                                 height: view.bounds.size.height)
            infoView.setInfo(element)
        }
    }

}
