//
//  InfoView.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/12.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class InfoView: UIView {

    @IBOutlet weak private var themeImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var messageLabel: UILabel!
    var pageNumber = 0

    class func make(frame: CGRect, pageNumber: Int) -> InfoView {
        let view = UINib(nibName: String(describing: InfoView.self), bundle: .main).instantiate(withOwner: self, options: nil).first as! InfoView
        view.frame = frame
        view.pageNumber = pageNumber
        return view
    }

    func setInfo(_ info: Infomation) {
        titleLabel.text = info.title
        messageLabel.text = info.message
        if let theme = ThemeType(rawValue: info.theme) {
            themeImageView.image = UIImage(named: theme.imageName)
            backgroundColor = theme.color
        } else {
            themeImageView.image = UIImage(named: "no_image")
            backgroundColor = .gray
        }
    }

}
