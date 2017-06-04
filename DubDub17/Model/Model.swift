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
    case wwdc2013 = 2013, wwdc2014, wwdc2015, wwdc2016,wwdc2017
}

extension EventYear: CustomStringConvertible {
    public var description: String {
        return "WWDC \(self.rawValue)"
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
    static var all: [Track] {
        return [.featured, .media, .developerTools, .graphicsAndGames, .systemsFrameworks, .appFrameworks, .design, .distribution]
    }
}


// MARK: - Platforms

public enum Platform: CustomStringConvertible {
    case iOS
    case macOS
    case tvOS
    case watchOS
    
    public var description: String {
        return String(describing: self)
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

protocol Filter {
    func reset()
}

class VideoFilter: Filter {
    
    var favoritesOnly: Bool
    var eventYear: EventYear?
    var platform: Platform?
    
    var unwatchedVideosOnly: Bool
    var downloadedVideosOnly: Bool
    
    var tracks: [Track: Bool]
    
    
    
    func enableTrack(_ track: Track) {
        tracks[track] = true
    }
    
    func disableTrack(_ track: Track) {
        tracks[track] = false
    }
    
    func reset() {
        favoritesOnly = false
        eventYear = nil
        platform = nil
        unwatchedVideosOnly = false
        downloadedVideosOnly = false
        enableAllTracks()
    }
    
    func enableAllTracks() {
        for track in Track.all {
            tracks[track] = true
        }
    }
    
    init() {
        
        self.favoritesOnly = true
        self.eventYear = nil
        self.platform = nil
        self.unwatchedVideosOnly = false
        self.downloadedVideosOnly = false
        
        self.tracks = [Track: Bool]()
        enableAllTracks()
        
    }
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
    public var playbackURL: URL {
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
            assetURL: URL(string: "http://download.blender.org/peach/bigbuckbunny_movies/BigBuckBunny_320x180.mp4")!
        )
    }
    
    static var defaultData: [Video] {
        return [
            fakeVideo,
            fakeVideo,
            fakeVideo,
            fakeVideo,
            fakeVideo
        ]
    }
}






