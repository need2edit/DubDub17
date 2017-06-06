//
//  VideosViewController.swift
//  DubDub17
//
//  Created by Jake Young on 6/1/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

protocol VideoSelectionDelegate: class {
    func didSelect(video: Video)
}

protocol VideosViewControllerDelegate: class {
    func controllerDidSelectAllVideos(_ controller: AllVideosViewController)
    func controllerDidSelectFeaturedVideos(_ controller: FeaturedVideosViewController)
    func controllerDidTapSearchButton(_ controller: AllVideosViewController)
    func controllerDidTapFilterButton(_ controller: AllVideosViewController)
}

class VideosViewController: UIViewController {

    weak var delegate: VideosViewControllerDelegate?

    enum Scope: String {
        case featured
        case all
        
        var selectedIndex: Int {
            switch self {
            case .featured:
                return 0
            case .all:
                return 1
            }
        }
        
        var title: String {
            return self.rawValue.capitalized
        }
    }
    
    var scope: Scope = .featured {
        didSet {
            updateView()
        }
    }

    @IBOutlet weak private var scopeSegmentedControl: UISegmentedControl!
    
    @IBAction func scopeSegmentedControlChanged(_ sender: UISegmentedControl) {
        guard
            let title = sender.titleForSegment(at: sender.selectedSegmentIndex),
            let newScope = Scope(rawValue: title.lowercased())
            else { return }
        scope = newScope
    
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        updateView()
    }
    
    private lazy var allVideosViewController: AllVideosViewController = {
        
        // Instantiate View Controller
        var viewController: AllVideosViewController = UIStoryboard.videos.instantiateViewController()
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()

    private func configureFilterButton() {

        if scope == .all {
            setupFilteringOptions()
        } else {
            resetFilteringOptions()
        }
    }

    private func setupFilteringOptions() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Filter",
            style: .plain,
            target: self,
            action: #selector(VideosViewController.filterButtonTapped(_:)))

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(VideosViewController.searchButtonTapped(_:)))
    }

    private func resetFilteringOptions() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil
    }
    
    private lazy var featuredVideosViewController: FeaturedVideosViewController = {
        
        // Instantiate View Controller
        var viewController: FeaturedVideosViewController = UIStoryboard.videos.instantiateViewController()
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private func updateView() {
        switch scope {
        case .featured:
            remove(asChildViewController: allVideosViewController)
            add(asChildViewController: featuredVideosViewController)
            delegate?.controllerDidSelectFeaturedVideos(featuredVideosViewController)
        case .all:
            remove(asChildViewController: featuredVideosViewController)
            add(asChildViewController: allVideosViewController)
            delegate?.controllerDidSelectAllVideos(allVideosViewController)
        }
        configureFilterButton()
    }
    
    // MARK: - Helper Methods
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }

    func filterButtonTapped(_ sender: UIBarButtonItem) {
        delegate?.controllerDidTapFilterButton(allVideosViewController)
    }

    func searchButtonTapped(_ sender: UIBarButtonItem) {
        delegate?.controllerDidTapSearchButton(allVideosViewController)
    }

}
