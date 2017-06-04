//
//  Theme.swift
//  DubDub17
//
//  Created by Jake Young on 6/4/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import Foundation
import UIKit

public struct Theme {
    
    let primaryColor: UIColor
    
    public func apply(to window: UIWindow) {
        window.tintColor = self.primaryColor
    }
}
