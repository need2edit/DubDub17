//
//  FeaturedVideosViewModel.swift
//  DubDub17
//
//  Created by Jake Young on 6/2/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

final class Section: NSObject {

    var title: String?
    var videos: [Video]

    init(title: String?, videos: [Video]) {
        self.title = title
        self.videos = videos
        super.init()
    }
}

protocol SectionDelegate {
    func didSelect(video: Video)
}

class SectionViewModel: NSObject {

    let currentSection: Section
    let delegate: SectionDelegate

    init(section: Section, delegate: SectionDelegate) {
        self.currentSection = section
        self.delegate = delegate
        super.init()
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfItemsInSection(_ section: Int) -> Int {
        return currentSection.videos.count
    }

    func getItem(at indexPath: IndexPath) -> Video {
        return currentSection.videos[indexPath.row]
    }

    func configureCell(_ cell: VideoCell, at indexPath: IndexPath) {
        cell.backgroundColor  = .white
        cell.imageView.backgroundColor = .gray
        cell.textLabel.text = getItem(at: indexPath).name
    }

    func title() -> String? {
        return currentSection.title
    }

}

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
