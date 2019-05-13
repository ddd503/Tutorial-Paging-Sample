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
}

final class TutorialViewPresenter {

    weak var delegate: TutorialViewPresenterDelegate?

    func viewDidLoad() {
        delegate?.setup()
    }
}
