//
//  VideoDetailsViewController.swift
//  DubDub17
//
//  Created by Jake Young on 6/1/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

// MARK: - View Model

public class VideoDetailsViewModel: ViewModel {
    
    let video: Video
    let actionsTintColor: UIColor
    
    var callback: (State) -> Void
    
    public struct State {
        var isWatched: Bool = false
        var downloadStatus: DownloadStatus = .notDownloaded
        var isFavorite: Bool = false
    }
    
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
    
    public func favoriteImage() -> UIImage? {
        return state.isFavorite ? #imageLiteral(resourceName: "StarFilled") : #imageLiteral(resourceName: "Star")
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

// MARK: - View Controller Delegation

protocol VideoDetailsViewControllerDelegate: class {
    func shareButtonTapped(_ controller: VideoDetailsViewController, video: Video)
    func favoriteButtonTapped(_ controller: VideoDetailsViewController, video: Video)
    func playVideoButtonTapped(_ controller: VideoDetailsViewController, video: Video)
    func markAsWatchedRowSelected(_ controller: VideoDetailsViewController, video: Video)
    func downloadVideoRowSelected(_ controller: VideoDetailsViewController, video: Video)
    func leaveFeedbackRowSelected(_ controller: VideoDetailsViewController, video: Video)
}

// MARK: - Layout Differences for Each Device

class iPhoneVideoDetailsViewController: VideoDetailsViewController { }
class iPadVideoDetailsViewController: VideoDetailsViewController { }

// MARK: - Video Details Controller
class VideoDetailsViewController: UIViewController, MVVM {
    
    var video: Video? {
        didSet {
            guard let video = video else { fatalError("video not set on video details view controller") }
            viewModel = VideoDetailsViewModel(video: video, tintColor: Theme.shared.primaryColor) { [unowned self] _ in
                DispatchQueue.main.async {
                    self.setupNavigation()
                    self.actionsTableView?.reloadData()
                }
            }
        }
    }
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleTextLabel: UILabel!
    @IBOutlet weak private var subtitleTextLabel: UILabel!
    @IBOutlet weak private var metaTextLabel: UILabel!
    @IBOutlet weak private var descriptionTextLabel: UILabel!
    
    @IBOutlet weak private var actionsTableView: UITableView!
    
    var viewModel: VideoDetailsViewModel!
    
    weak var delegate: VideoDetailsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionsTableView.dataSource = self
        actionsTableView.delegate = self
        actionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ActionCell")
        
    }
    
    private var shareBarButtonItem: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(VideoDetailsViewController.shareButtonTapped))
    }
    
    private var favoriteBarButtonItem: UIBarButtonItem {
        return UIBarButtonItem(image: viewModel?.favoriteImage(), style: .done, target: self, action: #selector(VideoDetailsViewController.favoriteButtonTapped))
    }

    func setupNavigation() {
        navigationItem.rightBarButtonItems = [shareBarButtonItem, favoriteBarButtonItem]
    }

    @IBAction func shareButtonTapped() {
        delegate?.shareButtonTapped(self, video: viewModel.video)
    }

    @IBAction func favoriteButtonTapped() {
        delegate?.favoriteButtonTapped(self, video: viewModel.video)
    }
    
    @IBAction func playButtonTapped() {
        delegate?.playVideoButtonTapped(self, video: viewModel.video)
    }
    
    public func toggleFavorite() {
        viewModel.state.isFavorite = !viewModel.state.isFavorite
    }
    
    public func toggleWatchedStatus() {
        viewModel.state.isWatched = !viewModel.state.isWatched
    }
    
}

extension VideoDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfActions() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell", for: indexPath)
        viewModel?.configureCell(cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = self.delegate else { return }
        viewModel?.selectVideo(at: indexPath, using: delegate, controller: self)
    }
    
}
