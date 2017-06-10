//
//  VideoFilterViewController.swift
//  DubDub17
//
//  Created by Jake Young on 6/10/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

protocol SectionItemType {
    var items: [Any] { get }
}

extension SectionItemType {
    var numberOfItems: Int {
        return items.count
    }
    
    func itemAtIndex(_ index: Int) -> Any {
        return items[index]
    }
}

protocol SectionedDataSource {
    associatedtype SectionType: SectionItemType
    var sections: [SectionType] { get }
}

extension SectionedDataSource {
    
    public func numberOfSections() -> Int {
        return sections.count
    }
    
    public func numberOfItemsInSection(_ section: Int) -> Int {
        return sections[section].numberOfItems
    }
    
    func sectionAtIndex(_ index: Int) -> SectionType {
        return sections[index]
    }
    
    public func getItem(at indexPath: IndexPath) -> Any {
        return sections[indexPath.section].itemAtIndex(indexPath.row)
    }
    
}

struct VideoFilterViewModel: ViewModel, SectionedDataSource {
    
    typealias SectionType = FilterSection
    
    enum FilterSection: SectionItemType {
        
        case favorites
        case events
        case platforms
        case videoOptions
        case tracks
        case reset
        
        var items: [Any] {
            switch self {
            case .favorites:
                return ["Favorites Only"]
            case .events:
                return EventYear.allValues
            case .platforms:
                return Platform.allValues
            case .videoOptions:
                return ["Unwatched videos only", "Downloaded videos only"]
            case .tracks:
                return Track.allValues
            case .reset:
                return ["Reset All Filters"]
            }
        }
        
        var title: String? {
            switch self {
                case .tracks: return "Tracks"
                default: return nil
            }
        }
    }
    
    var sections: [FilterSection] {
        return [
            .favorites,
            .events,
            .platforms,
            .videoOptions,
            .tracks,
            .reset
        ]
    }
    
    
    
    var filter: VideoFilter = VideoFilter.default {
        didSet {
            
        }
    }
    
    func titleForSection(_ section: Int) -> String? {
        return sectionAtIndex(section).title
    }

}

class VideoFilterViewController: UITableViewController, MVVM {
    var viewModel: VideoFilterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = VideoFilterViewModel()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToggleCell", for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForSection(section)
    }
}
