//
//  Datasource.swift
//  DubDub17
//
//  Created by Jake Young on 6/10/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import Foundation

class Data {
    
    static func featuredContent() -> [Section] {
        return [
            Section(title: "Featured", videos: Video.defaultData),
            Section(title: "Timeless Best Practices", videos: Video.defaultData),
            Section(title: "Design", videos: Video.defaultData),
            Section(title: "More Stuff", videos: Video.defaultData)
        ]
    }
    
}
