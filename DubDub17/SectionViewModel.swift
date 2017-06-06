//
//  SectionViewModel.swift
//  DubDub17
//
//  Created by Jake Young on 6/4/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import Foundation

public final class Section: NSObject {
    
    var title: String?
    var videos: [Video]
    
    init(title: String?, videos: [Video]) {
        self.title = title
        self.videos = videos
        super.init()
    }
}

public protocol SectionDelegate: class {
    func didSelect(video: Video)
}

public class SectionViewModel: NSObject, ViewModel {
    
    let currentSection: Section
    weak var delegate: SectionDelegate?
    
    init(section: Section, delegate: SectionDelegate) {
        self.currentSection = section
        self.delegate = delegate
        super.init()
    }
    
    public func numberOfSections() -> Int {
        return 1
    }
    
    public func numberOfItemsInSection(_ section: Int) -> Int {
        return currentSection.videos.count
    }
    
    public func getItem(at indexPath: IndexPath) -> Video {
        return currentSection.videos[indexPath.row]
    }
    
    public func configureCell(_ cell: VideoCell, at indexPath: IndexPath) {
        cell.backgroundColor  = .white
        cell.setImageBackgroundColor(.gray)
        cell.updateTitle(getItem(at: indexPath).name)
    }
    
    public func title() -> String? {
        return currentSection.title
    }
    
}
