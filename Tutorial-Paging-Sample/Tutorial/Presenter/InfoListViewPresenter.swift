//
//  InfoListViewPresenter.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/12.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import Foundation

protocol InfoListViewPresenterDelegate: class {
    func setup()
    func preparedInfoList()
}

class InfoListViewPresenter {

    weak var delegate: InfoListViewPresenterDelegate?
    private(set) var infomationList = [Infomation]()

    // MARK: Lifecycle
    func viewDidLoad() {
        delegate?.setup()
        infomationList = TutorialDataStore.requestTutorialInfo()
        guard !infomationList.isEmpty else {
            // エラー用のセルを出すもあり
            fatalError("ローカルにチュートリアル情報がありません")
        }
        delegate?.preparedInfoList()
    }

}
