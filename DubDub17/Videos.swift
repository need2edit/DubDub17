//
//  VideoCoordinator.swift
//  DubDub17
//
//  Created by Jake Young on 6/3/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import AVKit
import UIKit
import AVFoundation

class VideosCoordinator: Coordinator {

    var screen: UINavigationController
    var videoPlayer: AVPlayerViewController?

    init(_ screens: Screens) {
        self.screen = screens.videosRoot()
    }

    func start() {
        let vc: VideosViewController = UIStoryboard.videos.instantiateViewController()
        vc.delegate = self
        screen.pushViewController(vc, animated: false)
    }

}

// MARK: - Showing Video Details

public protocol Playable {
    var mediaURL: URL { get }
}

public protocol Sharable {
    var sharingURL: URL { get }
}

extension Sharable where Self: Playable {
    var sharingURL: URL {
        return mediaURL
    }
}

extension VideosCoordinator {
    
    /// Shows the thumbnail and description information for a given video.
    ///
    /// - Parameters:
    ///   - video: the video you would like to show the details for
    ///   - controller: a navigation controller to push the details from (we may want this modal in the future)
    func showDetails(_ video: Video, from controller: UINavigationController?) {
        let details: VideoDetailsViewController = UIStoryboard.videos.instantiateViewController()
        details.delegate = self
        details.viewModel = VideoDetailsViewModel(video: video)
        controller?.pushViewController(details, animated: true)
    }
    
    func play<Item: Playable>(_ itemToPlay: Item, from controller: UIViewController?) {
        
        let context = controller ?? self.screen
        
        let videosVC = VideoPlayerViewController(itemToPlay: itemToPlay)
//        controller?.performSegue(withIdentifier: "PlayVideo", sender: nil)
        
        context.present(videosVC, animated: true) {
            videosVC.play()
        }
        
    }
    
    func share(_ item: Playable) {
        let objectsToShare = [item]
        let vc = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        screen.present(vc, animated: true, completion: nil)
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
        showDetails(video, from: controller.navigationController)
    }

}

extension VideosCoordinator: VideoDetailsViewControllerDelegate {


    // MARK: - Video Details

    func shareButtonTapped(_ controller: VideoDetailsViewController, video: Video) {
        share(video)
    }

    func favoriteButtonTapped(_ controller: VideoDetailsViewController, video: Video) {
        play(video, from: controller)
    }
    
}
