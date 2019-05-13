//
//  InfoViewCell.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/13.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class InfoViewCell: UICollectionViewCell {

    @IBOutlet weak private var themeImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var messageLabel: UILabel!
    var pageNumber = 0

    static var identifier: String {
        return String(describing: self)
    }

    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: .main)
    }

    func setInfo(_ info: Infomation) {
        titleLabel.text = info.title
        messageLabel.text = info.message
        pageNumber = info.pageNumber
        if let theme = ThemeType(rawValue: info.theme) {
            themeImageView.image = UIImage(named: theme.imageName)
            backgroundColor = theme.color
        } else {
            themeImageView.image = UIImage(named: "no_image")
            backgroundColor = .gray
        }
    }

}
