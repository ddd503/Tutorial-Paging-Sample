//
//  Infomation.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/11.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

struct TutorialData: Decodable {
    let info: [Infomation]
}

struct Infomation: Decodable {
    let pageNumber: Int
    let title: String
    let message: String
    let theme: String

    private enum CodingKeys: String, CodingKey {
        case pageNumber = "number"
        case title
        case message
        case theme
    }
}
