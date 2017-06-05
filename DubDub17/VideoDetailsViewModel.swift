//
//  File.swift
//  DubDub17
//
//  Created by Jake Young on 6/4/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

public class VideoDetailsViewModel: ViewModel {
    
    enum Action: CustomStringConvertible {
        case watched
        case download
        case feedback
        
        var description: String {
            switch self {
            case .watched:
                return "Mark as Unwatched"
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
    
    public init(video: Video, tintColor: UIColor) {
        self.video = video
        self.actionsTintColor = tintColor
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
    
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let action = actions[indexPath.row]
        cell.textLabel?.text = action.description
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
