//
//  FeaturedVideosViewModel.swift
//  DubDub17
//
//  Created by Jake Young on 6/2/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

struct FeaturedViewModel {

    var sections: [Section] = [
        Section(title: "Featured", videos: Video.defaultData),
        Section(title: "Timeless Best Practices", videos: Video.defaultData),
        Section(title: "Design", videos: Video.defaultData),
        Section(title: "More Stuff", videos: Video.defaultData)
    ]

    func numberOfSections() -> Int {
        return sections.count
    }

    func numberOfItemsInSection(_ section: Int) -> Int {
        return 1
    }

    func getItem(at indexPath: IndexPath) -> Section {
        return sections[indexPath.section]
    }

    func titleForSection(section: Int) -> String? {
        return sections[section].title
    }

    func viewModel(at indexPath: IndexPath, delegate: SectionDelegate) -> SectionViewModel {
        return SectionViewModel(section: getItem(at: indexPath), delegate: delegate)
    }

    func configureCell(_ cell: ScrollingRowCell, at indexPath: IndexPath, delegate: SectionDelegate) {
        cell.viewModel = viewModel(at: indexPath, delegate: delegate)
    }
    
}
