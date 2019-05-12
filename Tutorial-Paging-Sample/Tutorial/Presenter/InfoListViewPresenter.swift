//
//  InfoListViewPresenter.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/12.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import Foundation

protocol InfoListViewPresenterDelegate: class {
    func preparedInfoList(_ infoList: [Infomation])
}

class InfoListViewPresenter {

    weak var delegate: InfoListViewPresenterDelegate?
    private var currentPageNumber = 1

    // MARK: Lifecycle
    func viewDidLoad() {
        let infomation = TutorialDataStore.requestTutorialInfo()
        guard !infomation.isEmpty else {
            fatalError("ローカルにチュートリアル情報がありません")
        }
        delegate?.preparedInfoList(infomation)
    }

}
