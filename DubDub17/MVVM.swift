//
//  MVVM.swift
//  DubDub17
//
//  Created by Jake Young on 6/5/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import Foundation

public protocol ViewModel { }

public protocol MVVM: class {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType! { get set }
}
