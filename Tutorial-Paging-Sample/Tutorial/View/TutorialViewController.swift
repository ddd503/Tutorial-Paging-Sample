//
//  TutorialViewController.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/11.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    class func make() -> TutorialViewController? {
        let storyBoard = UIStoryboard(name: String(describing: TutorialViewController.self), bundle: .main)
        return storyBoard.instantiateInitialViewController() as? TutorialViewController
    }

}
