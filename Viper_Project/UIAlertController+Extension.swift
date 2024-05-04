//
//  UIViewController+Extension.swift
//  Viper_Project
//
//  Created by Sheikh Ali on 03/05/2024.
//

import Foundation
import UIKit

extension UIAlertController {
    static func showAlert(title: String?, message: String?, preferredStyle: UIAlertController.Style = .alert,  controller: UIViewController, actions: [UIAlertAction] = [], completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        // Add default OK action if no actions provided
        if actions.isEmpty {
            let defaultAction = UIAlertAction(title: "OK", style: .default) { _ in
                completion?()
            }
            alertController.addAction(defaultAction)
        } else {
            // Add custom actions
            for action in actions {
                alertController.addAction(action)
            }
        }
        controller.present(alertController, animated: true, completion: nil)
    }
}
