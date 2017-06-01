//
//  App.swift
//  DubDub17
//
//  Created by Jake Young on 6/1/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

final class App: TabbedCoordinator {
    
    typealias RootViewController = UITabBarController
    
    let window: UIWindow
    
    var rootViewController: UITabBarController
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UITabBarController()
        
        self.window.rootViewController = self.rootViewController
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
