//
//  ThemeType.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/12.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

// ページ毎のテーマ
enum ThemeType: String {
    case red = "red"
    case blue = "blue"
    case green = "green"
    case orange = "orange"

    var imageName: String {
        switch self {
        case .red:
            return "airplain"
        case .blue:
            return "start"
        case .green:
            return "natural"
        case .orange:
            return "money"
        }
    }

    var color: UIColor {
        switch self {
        case .red:
            return .red
        case .blue:
            return .blue
        case .green:
            return .green
        case .orange:
            return .orange
        }
    }
}
