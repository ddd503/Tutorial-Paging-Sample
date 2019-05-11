//
//  InfoViewController.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/11.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak private var themeImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var messageLabel: UILabel!
    private let info: Infomation
    private let pageNumber: Int

    init(info: Infomation) {
        self.info = info
        self.pageNumber = info.pageNumber
        super.init(nibName: String(describing: InfoViewController.self),
                   bundle: Bundle(for: type(of: self)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = info.title
        messageLabel.text = info.message
        setTheme()
    }

    private func setTheme() {
        if let theme = ThemeType(rawValue: info.theme) {
            themeImageView.image = UIImage(named: theme.imageName)
            view.backgroundColor = theme.color
        } else {
            themeImageView.image = UIImage(named: "no_image")
            view.backgroundColor = .gray
        }
    }

}
