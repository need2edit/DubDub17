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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var subtitleTextLabel: UILabel!
    @IBOutlet weak var metaTextLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    
    @IBOutlet weak var actionsTableView: UITableView!
    
    var viewModel: VideoDetailsViewModel! {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
    }
    
    var delegate: VideoDetailsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        
        actionsTableView.dataSource = self
        actionsTableView.delegate = self
        actionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ActionCell")
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
        isFavorite = !isFavorite
    }
    
}

extension VideoDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfActions()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell", for: indexPath)
        viewModel.configureCell(cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = self.delegate else { return }
        viewModel.selectVideo(at: indexPath, using: delegate, controller: self)
    }
    
}
