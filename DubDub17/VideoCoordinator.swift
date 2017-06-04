//
//  VideoCoordinator.swift
//  DubDub17
//
//  Created by Jake Young on 6/3/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import Foundation

class VideosCoordinator: Coordinator {

    var screen: UINavigationController

    init(_ screens: Screens) {
        self.screen = screens.videosRoot()
    }

    func start() {
        let vc: VideosViewController = UIStoryboard.videos.instantiateViewController()
        vc.delegate = self
        screen.pushViewController(vc, animated: false)
    }

}

extension VideosCoordinator: VideosViewControllerDelegate {

    func controllerDidTapFilterButton(_ controller: AllVideosViewController) {

    }

    func controllerDidTapSearchButton(_ controller: AllVideosViewController) {

    }

    func controllerDidSelectAllVideos(_ controller: AllVideosViewController) {
        //        controller.delegate = self
    }

    func controllerDidSelectFeaturedVideos(_ controller: FeaturedVideosViewController) {
        controller.delegate = self
    }
}

extension VideosCoordinator: FeaturedVideosViewControllerDelegate {

    func featuredControllerDidSelectVideo(_ controller: FeaturedVideosViewController, video: Video) {
        let details: VideoDetailsViewController = UIStoryboard.videos.instantiateViewController()
        details.delegate = self
        details.viewModel = VideoDetailsViewModel(video: video)
        controller.navigationController?.pushViewController(details, animated: true)
    }

}

extension VideosCoordinator: VideoDetailsViewControllerDelegate {


    // MARK: - Video Details

    func shareButtonTapped(_ controller: VideoDetailsViewController, video: Video) {
        let url = URL(string: "https://www.apple.com/")!
        let objectsToShare = [url]
        let vc = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        controller.navigationController?.present(vc, animated: true, completion: nil)
    }

    func favoriteButtonTapped(_ controller: VideoDetailsViewController, video: Video) {
        
    }
    
}
