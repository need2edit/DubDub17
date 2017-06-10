//
//  Video.swift
//  DubDub17
//
//  Created by Jake Young on 6/4/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import Foundation

// MARK: - Event Year

public enum EventYear: Int {
    case all = 999, wwdc2013 = 2013, wwdc2014, wwdc2015, wwdc2016, wwdc2017
}

extension EventYear {
    static var allValues: [EventYear] {
        return [.all, .wwdc2013, .wwdc2014, .wwdc2015, .wwdc2016]
    }
}

extension EventYear: Comparable {
    
    public static func == (lhs: EventYear, rhs: EventYear) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
    public static func < (lhs: EventYear, rhs: EventYear) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

extension EventYear: CustomStringConvertible {
    public var description: String {
        switch self {
        case .all:
            return "All"
        default:
            return "WWDC \(self.rawValue)"
        }
        
    }
}

// MARK: - Tracks

public enum Track {
    case featured
    case media
    case developerTools
    case graphicsAndGames
    case systemsFrameworks
    case appFrameworks
    case design
    case distribution
}

extension Track: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .featured:
            return "Featured"
        case .media:
            return "Media"
        case .developerTools:
            return "Developer Tools"
        case .graphicsAndGames:
            return "Graphics & Games"
        case .systemsFrameworks:
            return "System Frameworks"
        case .appFrameworks:
            return "App Frameworks"
        case .design:
            return "Design"
        case .distribution:
            return "Distribution"
        }
    }
    
}

extension Track {
    static var allValues: [Track] {
        return [.featured, .media, .developerTools, .graphicsAndGames, .systemsFrameworks, .appFrameworks, .design, .distribution]
    }
}

// MARK: - Platforms

public enum Platform: CustomStringConvertible {
    
    case all
    case iOS
    case macOS
    case tvOS
    case watchOS
    
    public var description: String {
        return String(describing: self)
    }
}

extension Platform {
    static var allValues: [Platform] {
        return [.all, .iOS, .macOS, .tvOS, .watchOS]
    }
}

public enum ViewingStatus: CustomStringConvertible {
    
    case watched, unwatched
    
    public var description: String {
        return String(describing: self).capitalized
    }
}

public enum DownloadStatus {
    case downloaded, notDownloaded
}

public struct Video {
    public let name: String
    public let summary: String
    public let track: Track
    public let eventYear: EventYear
    public let assetURL: URL
}

extension Video: CustomStringConvertible {
    public var description: String {
        return name
    }
}

extension Video: Playable {
    public var mediaURL: URL {
        return assetURL
    }
}

extension Video {
    
    static var fakeVideo: Video {
        return Video(
            name: "Improving Existing Apps with Modern Best Practices",
            summary: "Lorem ipsum dolor sit amet.",
            track: .featured,
            eventYear: .wwdc2017,
            assetURL: URL(string: "https://tungsten.aaplimg.com/VOD/bipbop_adv_fmp4_example/master.m3u8")!
        )
    }
    
    static var defaultData: [Video] {
        return [
            fakeVideo,
            fakeVideo,
            fakeVideo,
            fakeVideo,
            fakeVideo,
            fakeVideo,
            fakeVideo,
            fakeVideo,
            fakeVideo,
            fakeVideo,
            fakeVideo
        ]
    }
}
