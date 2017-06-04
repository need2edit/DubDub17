//
//  File.swift
//  DubDub17
//
//  Created by Jake Young on 6/4/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import Foundation

public class VideoDetailsViewModel {
    
    let video: Video
    
    public init(video: Video) {
        self.video = video
    }
    
    public func titleText() -> String {
        return video.name
    }
}
