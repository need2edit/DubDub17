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

/** Videos coordinator will have a starting screen as a UINavigationController.
 *
 * This coordinator is in charge of: 
 * - pushing the details of a video on to the screen.
 * - switching between all and featured child view controllers
 * - showing or hiding the filters and search popups
 */
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

extension VideosCoordinator {
    
    private func setupDetailsViewController(_ viewController: VideoDetailsViewController, with video: Video) {
        viewController.delegate = self
        viewController.viewModel = VideoDetailsViewModel(video: video)
    }
    
    /// Shows the thumbnail and description information for a given video.
    ///
    /// - Parameters:
    ///   - video: the video you would like to show the details for
    ///   - controller: a navigation controller to push the details from (we may want this modal in the future)
    func showDetails(_ video: Video, from controller: UINavigationController?) {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            let details: iPadVideoDetailsViewController = UIStoryboard.videos.instantiateViewController()
            setupDetailsViewController(details, with: video)
            controller?.pushViewController(details, animated: true)
        } else {
            let details: iPhoneVideoDetailsViewController = UIStoryboard.videos.instantiateViewController()
            setupDetailsViewController(details, with: video)
            controller?.pushViewController(details, animated: true)
        }
    }
    
    func play<Item: Playable>(_ itemToPlay: Item, from controller: UIViewController?) {
        
        // We need something to present from, typically you want to do this on a root controller
        let context = controller ?? self.screen
        
        let videosVC = VideoPlayerViewController(itemToPlay: itemToPlay)
        
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
        controller.toggleFavorite()
    }
    
    func playVideoButtonTapped(_ controller: VideoDetailsViewController, video: Video) {
        play(video, from: controller)
    }
    
    func downloadVideoRowSelected(_ controller: VideoDetailsViewController, video: Video) {
        controller.showAlert(title: #function)
    }
    
    func markAsWatchedRowSelected(_ controller: VideoDetailsViewController, video: Video) {
        controller.showAlert(title: #function)
    }
    
    func leaveFeedbackRowSelected(_ controller: VideoDetailsViewController, video: Video) {
        controller.showAlert(title: #function)
    }
    
}
