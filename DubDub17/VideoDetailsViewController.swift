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
}



class iPhoneVideoDetailsViewController: VideoDetailsViewController { }
class iPadVideoDetailsViewController: VideoDetailsViewController { }

class VideoDetailsViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleTextLabel: UILabel!
    @IBOutlet var subtitleTextLabel: UILabel!
    @IBOutlet var metaTextLabel: UILabel!
    @IBOutlet var descriptionTextLabel: UILabel!
    
    var viewModel: VideoDetailsViewModel!
    var delegate: VideoDetailsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }

    func setupNavigation() {
        let share = UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action: #selector(VideoDetailsViewController.shareButtonTapped))
        let favorite = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(VideoDetailsViewController.favoriteButtonTapped))
        navigationItem.rightBarButtonItems = [share, favorite]
    }

    func shareButtonTapped() {
        delegate?.shareButtonTapped(self, video: viewModel.video)
    }

    func favoriteButtonTapped() {
        delegate?.favoriteButtonTapped(self, video: viewModel.video)
    }

}
