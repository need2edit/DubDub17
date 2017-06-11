//
//  Filter.swift
//  DubDub17
//
//  Created by Jake Young on 6/10/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import Foundation

protocol Filter {
    func reset()
}

class VideoFilter: Filter {
    
    var favoritesOnly: Bool = false
    var eventYear: EventYear = .all
    var platform: Platform = .all
    
    var unwatchedVideosOnly: Bool = false
    var downloadedVideosOnly: Bool = false
    
    var tracks: [Track] = []
    var trackOptions: [Track: Bool] = [:]
    
    func enableTrack(_ track: Track) {
        trackOptions[track] = true
    }
    
    func disableTrack(_ track: Track) {
        trackOptions[track] = false
    }
    
    func isTrackEnabled(_ track: Track) -> Bool {
        guard let enabled = trackOptions[track] else { return false }
        return enabled
    }
    
    func reset() {
        favoritesOnly = false
        eventYear = .all
        platform = .all
        unwatchedVideosOnly = false
        downloadedVideosOnly = false
        enableAllTracks()
    }
    
    func enableAllTracks() {
        for track in tracks {
            trackOptions[track] = true
        }
    }
    
    public init(favoritesOnly: Bool = false, eventYear: EventYear = .all, platform: Platform = .all, unwatchedVideosOnly: Bool = false, downloadedVideosOnly: Bool = false, tracks: [Track] = Track.allValues) {
        self.favoritesOnly = favoritesOnly
        self.eventYear = eventYear
        self.platform = platform
        self.unwatchedVideosOnly = unwatchedVideosOnly
        self.downloadedVideosOnly = downloadedVideosOnly
        self.tracks = tracks
        enableAllTracks()
        
    }

    static var `default`: VideoFilter {
        return VideoFilter()
    }
    
}
