//
//  App.swift
//  DubDub17
//
//  Created by Jake Young on 6/1/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

class Screens {
    
    func initialViewControllerForStoryboard<A: UIViewController>(_ storyboard: UIStoryboard.Storyboard) -> A {
        guard let vc = UIStoryboard(storyboard).instantiateInitialViewController() as? A else { fatalError() }
        return vc
    }
    
    func root() -> UITabBarController {
        let tc: UITabBarController = initialViewControllerForStoryboard(.main)
        return tc
    }
    
    
    func videos() -> UIViewController {
        let vc: UINavigationController = initialViewControllerForStoryboard(.videos)
        vc.tabBarItem = App.Tab.videos.tabBarItem
        return vc
    }
    
    func schedule() -> UIViewController {
        let vc: UINavigationController = initialViewControllerForStoryboard(.schedule)
        vc.tabBarItem = App.Tab.schedule.tabBarItem
        return vc
    }
    
    func news() -> UIViewController {
        let vc: UINavigationController = initialViewControllerForStoryboard(.news)
        vc.tabBarItem = App.Tab.news.tabBarItem
        return vc
    }
    
    func venue() -> UIViewController {
        let vc: UINavigationController = initialViewControllerForStoryboard(.venue)
        vc.tabBarItem = App.Tab.venue.tabBarItem
        return vc
    }
}

final class App: TabbedCoordinator {
    
    typealias RootViewController = UITabBarController
    
    let window: UIWindow
    
    var rootViewController: UITabBarController
    var screens: Screens
    
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UITabBarController()
        self.screens = Screens()
        
        self.window.rootViewController = self.rootViewController
        setupTabs()
    }
    
    func setupTabs() {
        self.rootViewController.setViewControllers(availableTabs(), animated: false)
    }
    
    func availableTabs() -> [UIViewController] {
        return [screens.videos(), screens.schedule(), screens.news(), screens.venue()]
    }
    
}

extension App {
    
    enum Tab: Int, TabItem {
        case videos = 0
        case schedule
        case news
        case venue
        
        var title: String? {
            switch self {
            case .videos: return "Videos"
            case .schedule: return "Schedule"
            case .news: return "News"
            case .venue: return "Venue"
            }
        }
        
        var image: UIImage? {
            guard let title = title else { return nil }
            return UIImage(named: title)
        }
    }
    
}
