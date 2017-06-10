//
//  FeaturedVideosViewModel.swift
//  DubDub17
//
//  Created by Jake Young on 6/2/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

struct FeaturedViewModel: ViewModel {

    var sections: [Section] = Data.featuredContent()

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
