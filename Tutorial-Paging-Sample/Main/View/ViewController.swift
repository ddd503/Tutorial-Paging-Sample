//
//  ViewController.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/11.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ViewControllerPresenterDelegate {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var waitingView: UIView!
    private let presenter = ViewControllerPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }

    func presentTutorialViewController() {
        
    }

}

