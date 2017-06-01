//
//  Coordinator.swift
//  Coordinators
//
//  Created by Jake Young on 5/30/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

protocol Coordinator { }

protocol Presenter: Coordinator {
    func start(presentingFrom viewController: UIViewController?)
    func finish()
}

protocol RootViewCoordinator: Coordinator {
    associatedtype RootViewController: UIViewController
    var rootViewController: RootViewController { get }
}

protocol TabItem {
    var selectedIndex: Int { get }
    var title: String? { get }
    var image: UIImage? { get }
    var selectedImage: UIImage? { get }
}

extension TabItem where Self: RawRepresentable, Self.RawValue == Int {
    
    var selectedImage: UIImage? {
        return nil
    }
    
    var selectedIndex: Int {
        return self.rawValue
    }
}

extension TabItem {
    var tabBarItem: UITabBarItem {
        return UITabBarItem(title: title, image: image, selectedImage: selectedImage)
    }
}

protocol TabbedCoordinator: RootViewCoordinator {
    associatedtype RootViewController: UITabBarController
    associatedtype Tab: RawRepresentable, TabItem
}

extension TabbedCoordinator where Self.Tab.RawValue == Int {
    
    func selectTab(atIndex index: Int) {
        rootViewController.selectedIndex = index
    }
    
    func selectTab(_ tab: Tab) {
        selectTab(atIndex: tab.selectedIndex)
    }
    
}

protocol NavigationCoordinator: RootViewCoordinator, Presenter {
    associatedtype RootViewController: UINavigationController
}

class BaseNavigationCoordinator: NavigationCoordinator {
    
    typealias RootViewController = UINavigationController
    
    var rootViewController: UINavigationController
    
    init() {
        self.rootViewController = UINavigationController()
    }
    
    enum Style {
        case fullscreen
        case modal
        
        var presentationStyle: UIModalPresentationStyle {
            switch self {
            case .fullscreen: return .fullScreen
            case .modal: return .pageSheet
            }
        }
        
        
    }
    
    var style: Style = .modal
    
    func start(presentingFrom viewController: UIViewController?) {
        loadBaseViewController()
        self.rootViewController.modalPresentationStyle = style.presentationStyle
        viewController?.present(self.rootViewController, animated: true, completion: nil)
    }
    
    func baseViewController() -> UIViewController? {
        fatalError("Override in subclass")
    }
    
    func loadBaseViewController() {
        guard let base = baseViewController() else { return }
        self.rootViewController.pushViewController(base, animated: false)
    }
    
    func finish() {
        self.rootViewController.dismiss(animated: true, completion: nil)
    }
    
}
