//
//  ViewControllerPresenter.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/11.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import Foundation

protocol ViewControllerPresenterDelegate: class {
    func presentTutorialViewController()
}

final class ViewControllerPresenter {

    weak var delegate: ViewControllerPresenterDelegate?
    var isNotFinishTutorial = true

    func viewDidAppear() {
        if isNotFinishTutorial {
            delegate?.presentTutorialViewController()

            isNotFinishTutorial = false
        }
    }

    func didTapTutorialButton() {
        delegate?.presentTutorialViewController()
    }
    
}
