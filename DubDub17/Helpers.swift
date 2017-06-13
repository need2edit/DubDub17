//
//  Helpers.swift
//  DubDub17
//
//  Created by Jake Young on 6/4/17.
//  Copyright © 2017 Jake Young. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String?, message: String? = nil, actions: [UIAlertAction] = [], preferredStyle: UIAlertControllerStyle = .alert) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        if actions.isEmpty {
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        } else {
            for action in actions {
                alert.addAction(action)
            }
        }
        
        present(alert, animated: true, completion: nil)
        
    }
}


extension UIViewController {
   @IBAction func simpleDismiss() {
        dismiss(animated: true, completion: nil)
    }
}
