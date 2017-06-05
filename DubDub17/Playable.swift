//
//  Playable.swift
//  DubDub17
//
//  Created by Jake Young on 6/4/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import Foundation

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
