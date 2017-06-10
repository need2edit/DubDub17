//
//  Storyboard.swift
//  DubDub17
//
//  Created by Jake Young on 6/1/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

enum StoryboardIdentifier: String {
    case main
    case videos
    case schedule
    case news
    case venue
}

enum ViewController: String {
    case AllVideosViewController
    case FeaturedVideosViewController
    case VideoDetailsViewController
    case iPadVideoDetailsViewController
    case iPhoneVideoDetailsViewController
    case VideoFilterViewController
    
    func viewControllerClass<A: UIViewController>() -> A {
        switch self {
        case .AllVideosViewController: return ViewController.AllVideosViewController as! A
        case .FeaturedVideosViewController: return ViewController.FeaturedVideosViewController as! A
        case .VideoDetailsViewController: return ViewController.VideoDetailsViewController as! A
        case .iPadVideoDetailsViewController: return ViewController.iPadVideoDetailsViewController as! A
        case .iPhoneVideoDetailsViewController: return ViewController.iPhoneVideoDetailsViewController as! A
        case .VideoFilterViewController: return ViewController.VideoFilterViewController as! A
        }
    }
}

extension UIStoryboard {
    
}

extension UIStoryboard {
    
    convenience init(identifier: StoryboardIdentifier) {
        self.init(name: identifier.rawValue.capitalized, bundle: Bundle.main)
    }
    
    func instantiateViewController<A: UIViewController>() -> A {
        return instantiateViewController(withIdentifier: String(describing: A.self)) as! A
    }
    
    static var main: UIStoryboard {
        return UIStoryboard(identifier: .main)
    }
    
    static var videos: UIStoryboard {
        return UIStoryboard(identifier: .videos)
    }
    
    static var schedule: UIStoryboard {
        return UIStoryboard(identifier: .schedule)
    }
    
    static var news: UIStoryboard {
        return UIStoryboard(identifier: .news)
    }
    
    static var venue: UIStoryboard {
        return UIStoryboard(identifier: .venue)
    }
}
