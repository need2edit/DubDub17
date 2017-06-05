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

class iPhoneVideoDetailsViewController: VideoDetailsViewController { }
class iPadVideoDetailsViewController: VideoDetailsViewController { }

class VideoDetailsViewController: UIViewController, MVVM {
    
    var video: Video? {
        didSet {
            guard let video = video else { fatalError() }
            viewModel = VideoDetailsViewModel(video: video, tintColor: Theme.shared.primaryColor) { [unowned self] state in
                DispatchQueue.main.async {
                    self.setupNavigation()
                    self.actionsTableView?.reloadData()
                }
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var subtitleTextLabel: UILabel!
    @IBOutlet weak var metaTextLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    
    @IBOutlet weak var actionsTableView: UITableView!
    
    var viewModel: VideoDetailsViewModel!
    
    var delegate: VideoDetailsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionsTableView.dataSource = self
        actionsTableView.delegate = self
        actionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ActionCell")
        
    }
    
    private var shareBarButtonItem: UIBarButtonItem {
        return UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action: #selector(VideoDetailsViewController.shareButtonTapped))
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
