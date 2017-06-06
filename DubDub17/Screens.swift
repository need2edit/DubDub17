//
//  Screens.swift
//  DubDub17
//
//  Created by Jake Young on 6/3/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

class Screens {

    func initialViewControllerForStoryboard<A: UIViewController>(_ storyboard: StoryboardIdentifier) -> A {
        guard let vc = UIStoryboard(identifier: storyboard).instantiateInitialViewController() as? A else { fatalError("there is no intial view controller for storyboard: \(storyboard), viewController class: \(A.self)") }
        return vc
    }

    func root() -> UITabBarController {
        let tc: UITabBarController = initialViewControllerForStoryboard(.main)
        return tc
    }

    func videosRoot() -> UINavigationController {
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
