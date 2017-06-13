//
//  VideoFilterViewController.swift
//  DubDub17
//
//  Created by Jake Young on 6/10/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

protocol ValueCell {
    associatedtype Value
    func configureCellWithValue(_ value: Value)
}

protocol ValueRepresentable {
    associatedtype Value
    var value: Value { get }
}

public class ToggleCell: UITableViewCell, ValueCell {
    
    typealias Value = (String, Bool)
    
    @IBOutlet weak var valueTextLabel: UILabel!
    @IBOutlet weak var toggleSwitch: UISwitch!
    
    func configureCellWithValue(_ value: (String, Bool)) {
        valueTextLabel.text = value.0
        toggleSwitch.setOn(value.1, animated: true)
    }
}

public final class IndicatorToggleCell: ToggleCell {
    
    typealias Value = (String, Bool, UIColor)
    
    @IBOutlet weak var indicatorView: UIView!
    
    var indicatorColor: UIColor = .white {
        didSet {
            indicatorView.backgroundColor = indicatorColor
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        indicatorView.layer.cornerRadius = 4.0
    }
    
    func configureCellWithValue(_ value: (String, Bool, UIColor)) {
        valueTextLabel.text = value.0
        toggleSwitch.setOn(value.1, animated: true)
        indicatorColor = value.2
    }
}

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
        
        var reuseId: String {
            switch self {
            case .favorites, .videoOptions:
                return "ToggleCell"
            case .events, .platforms:
                return "CheckmarkCell"
            case .tracks:
                return "TrackCell"
            case .reset:
                return "ResetCell"
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
    
    func colorForTrack(_ track: Track) -> UIColor {
        switch track {
        case .featured:
            return #colorLiteral(red: 0.2490291595, green: 0.355263561, blue: 0.4410368502, alpha: 1)
        case .media:
            return #colorLiteral(red: 0.861653924, green: 0.1677098572, blue: 0.2853348255, alpha: 1)
        case .developerTools:
            return #colorLiteral(red: 0.8989149928, green: 0.4645496607, blue: 0.2384812534, alpha: 1)
        case .graphicsAndGames:
            return #colorLiteral(red: 0.881817162, green: 0.6826372743, blue: 0.02100795321, alpha: 1)
        case .systemsFrameworks:
            return #colorLiteral(red: 0.6854068637, green: 0.7508594394, blue: 0.4246983826, alpha: 1)
        case .appFrameworks:
            return #colorLiteral(red: 0.1440612376, green: 0.655739069, blue: 0.586232543, alpha: 1)
        case .design:
            return #colorLiteral(red: 0.1122190729, green: 0.6833254695, blue: 0.81986624, alpha: 1)
        case .distribution:
            return #colorLiteral(red: 0.5343526006, green: 0.3801214993, blue: 0.6571785808, alpha: 1)
        }
    }
    
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        
        cell.selectionStyle = .none
        
        switch (sectionAtIndex(indexPath.section), indexPath.row) {
            case (.favorites, _):
                if let cell = cell as? ToggleCell, let label = getItem(at: indexPath) as? String {
                    cell.configureCellWithValue((label, filter.favoritesOnly))
                }
            case (.videoOptions, let row):
                if let cell = cell as? ToggleCell, let label = getItem(at: indexPath) as? String {
                    let isEnabled = row == 0 ? filter.unwatchedVideosOnly : filter.downloadedVideosOnly
                    cell.configureCellWithValue((label, isEnabled))
            }
            case (.events, _):
                if let event = getItem(at: indexPath) as? EventYear {
                    cell.textLabel?.text = event.description
                    cell.accessoryType = event == filter.eventYear ? .checkmark : .none
                }
        case (.tracks, _):
            if let cell = cell as? IndicatorToggleCell, let track = getItem(at: indexPath) as? Track {
                let isEnabled = filter.isTrackEnabled(track)
                let value = (track.description, isEnabled, colorForTrack(track))
                cell.configureCellWithValue(value)
            }
            default:
                return
        }
        
    }

}

class VideoFilterViewController: UITableViewController, MVVM {
    var viewModel: VideoFilterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = VideoFilterViewModel()
        if UIDevice.current.userInterfaceIdiom == .phone {
            navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(UIViewController.simpleDismiss))
            navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .save, target: self, action: #selector(UIViewController.simpleDismiss))
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.sectionAtIndex(indexPath.section).reuseId, for: indexPath)
        viewModel.configureCell(cell, at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForSection(section)
    }
}
