//
//  File.swift
//  DubDub17
//
//  Created by Jake Young on 6/4/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

public class VideoDetailsViewModel: ViewModel {
    
    public struct State {
        var isWatched: Bool = false
        var downloadStatus: DownloadStatus = .notDownloaded
        var isFavorite: Bool = false
    }
    
    public func favoriteImage() -> UIImage? {
        return state.isFavorite ? #imageLiteral(resourceName: "StarFilled") : #imageLiteral(resourceName: "Star")
    }
    
    var callback: (State) -> Void
    
    var state: State = State() {
        didSet {
            callback(state)
        }
    }
    
    enum Action: CustomStringConvertible {
        
        case watched
        case download
        case feedback
        
        var description: String {
            switch self {
            case .watched(let isWatched):
                return "Mark as \(isWatched)"
            case .download:
                return "Download Video"
            case .feedback:
                return "Leave Feedback"
            }
        }
    }
    
    var actions: [Action] = [
        .watched,
        .download,
        .feedback
    ]
    
    let video: Video
    let actionsTintColor: UIColor
    
    public init(video: Video, tintColor: UIColor, callback: @escaping (State) -> Void) {
        self.video = video
        self.actionsTintColor = tintColor
        self.callback = callback
        self.callback(state)
    }
    
    public func isWatchedText() -> String {
        return state.isWatched ? "Mark as Unwatched": "Mark as Watched"
    }
    
    public func titleText() -> String {
        return video.name
    }
    
    func numberOfActions() -> Int {
        return actions.count
    }
    
    func action(at indexPath: IndexPath) -> Action {
        return actions[indexPath.row]
    }
    
    func cellTextForAction(_ action: Action) -> String {
        switch action {
        case .download:
            return action.description
        case .watched:
            return isWatchedText()
        case .feedback:
            return action.description
        }
    }
    
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let action = actions[indexPath.row]
        cell.textLabel?.text = cellTextForAction(action)
        cell.textLabel?.textColor = actionsTintColor
    }
    
    func selectVideo(at indexPath: IndexPath, using delegate: VideoDetailsViewControllerDelegate, controller: VideoDetailsViewController) {
        switch (indexPath.section, indexPath.row) {
        case (0, let row) where row == 0:
            delegate.markAsWatchedRowSelected(controller, video: video)
        case (0, let row) where row == 1:
            delegate.downloadVideoRowSelected(controller, video: video)
        case (0, let row) where row == 2:
            delegate.leaveFeedbackRowSelected(controller, video: video)
        default:
            return
        }
    }
    
}
