//
//  TutorialDataStore.swift
//  Tutorial-Paging-Sample
//
//  Created by kawaharadai on 2019/05/12.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import Foundation

class TutorialDataStore {

    static func requestTutorialInfo() -> [Infomation] {
        guard let jsonFilePath = Bundle.main.path(forResource: "tutorial_Info", ofType: "json") else {
            print("ローカルのjsonファイルのpathの取得に失敗")
            return []
        }

        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFilePath), options: .mappedIfSafe)
            let mappedData = try JSONDecoder().decode(TutorialData.self, from: jsonData)
            return mappedData.info
        } catch let error as NSError {
            print("ローカルのjsonファイル取得に失敗：\(error.localizedDescription)")
            return []
        }
    }
    
}
