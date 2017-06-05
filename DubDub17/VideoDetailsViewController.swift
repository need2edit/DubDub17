//
//  VideoDetailsViewController.swift
//  DubDub17
//
//  Created by Jake Young on 6/1/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

protocol VideoDetailsViewControllerDelegate {
    func shareButtonTapped(_ controller: VideoDetailsViewController, video: Video)
    func favoriteButtonTapped(_ controller: VideoDetailsViewController, video: Video)
    func playVideoButtonTapped(_ controller: VideoDetailsViewController, video: Video)
    func markAsWatchedRowSelected(_ controller: VideoDetailsViewController, video: Video)
    func downloadVideoRowSelected(_ controller: VideoDetailsViewController, video: Video)
    func leaveFeedbackRowSelected(_ controller: VideoDetailsViewController, video: Video)
}

internal protocol VideoActionsViewControllerDelegate {
    func markAsWatchedRowSelected(_ controller: VideoActionsViewController, video: Video)
    func downloadVideoRowSelected(_ controller: VideoActionsViewController, video: Video)
    func leaveFeedbackRowSelected(_ controller: VideoActionsViewController, video: Video)
}

class iPhoneVideoDetailsViewController: VideoDetailsViewController { }
class iPadVideoDetailsViewController: VideoDetailsViewController { }

class VideoDetailsViewController: UIViewController, VideoActionsViewControllerDelegate {
    
    func leaveFeedbackRowSelected(_ controller: VideoActionsViewController, video: Video) {
        print(#function)
        delegate?.leaveFeedbackRowSelected(self, video: video)
    }

    func downloadVideoRowSelected(_ controller: VideoActionsViewController, video: Video) {
        print(#function)
        delegate?.downloadVideoRowSelected(self, video: video)
    }

    func markAsWatchedRowSelected(_ controller: VideoActionsViewController, video: Video) {
        print(#function)
        delegate?.markAsWatchedRowSelected(self, video: video)
    }

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var subtitleTextLabel: UILabel!
    @IBOutlet weak var metaTextLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    
    var viewModel: VideoDetailsViewModel!
    var delegate: VideoDetailsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    var isFavorite: Bool = false {
        didSet {
            setupNavigation()
        }
    }
    
    private func favoriteImage() -> UIImage? {
        return isFavorite ? #imageLiteral(resourceName: "StarFilled") : #imageLiteral(resourceName: "Star")
    }
    
    private var shareBarButtonItem: UIBarButtonItem {
        return UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action: #selector(VideoDetailsViewController.shareButtonTapped))
    }
    
    private var favoriteBarButtonItem: UIBarButtonItem {
        return UIBarButtonItem(image: favoriteImage(), style: .done, target: self, action: #selector(VideoDetailsViewController.favoriteButtonTapped))
    }

    func setupNavigation() {
        navigationItem.rightBarButtonItems = [shareBarButtonItem, favoriteBarButtonItem]
    }

    func shareButtonTapped() {
        delegate?.shareButtonTapped(self, video: viewModel.video)
    }

    func favoriteButtonTapped() {
        delegate?.favoriteButtonTapped(self, video: viewModel.video)
    }
    
    func playButtonTapped() {
        delegate?.playVideoButtonTapped(self, video: viewModel.video)
    }
    
    public func toggleFavorite() {
        isFavorite = !isFavorite
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let actions = segue.destination as? VideoActionsViewController, let identifier = segue.identifier, identifier == "EmbedActions" {
            actions.delegate = self
            actions.video = viewModel.video
        }
    }
    
    
}


// TODO: Formalize this with a view model / state machine
class VideoActionsViewController: UITableViewController {
    
    var video: Video?
    public var delegate: VideoActionsViewControllerDelegate? {
        didSet {
            print("actions delegate set")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ActionCell")
        tableView.delegate = self
    }
    
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell", for: indexPath)
        configureCell(cell, at: indexPath)
        return cell
    }
    
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let action = actions[indexPath.row]
        cell.textLabel?.text = action.description
        cell.textLabel?.textColor = self.view.tintColor
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let video = video else { return }
        
        switch (indexPath.section, indexPath.row) {
        case (0, let row) where row == 0:
            delegate?.markAsWatchedRowSelected(self, video: video)
        case (0, let row) where row == 1:
            delegate?.downloadVideoRowSelected(self, video: video)
        case (0, let row) where row == 2:
            delegate?.leaveFeedbackRowSelected(self, video: video)
        default:
            return
        }
        
    }
    
}

