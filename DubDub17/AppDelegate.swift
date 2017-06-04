//
//  AppDelegate.swift
//  DubDub17
//
//  Created by Jake Young on 6/1/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var app: App?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        guard let window = window else { fatalError() }
        app = App(window: window)
        
        return true
    }

}

