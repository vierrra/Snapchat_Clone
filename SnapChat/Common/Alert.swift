//
//  Alert.swift
//  SnapChat
//
//  Created by Renato on 6/10/21.
//

import Foundation
import UIKit

class Alert {
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func showAlertAction(_ title: String, _ message: String) {
        let alert          = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButtonAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okButtonAction)
        controller.present(alert, animated: true, completion: nil)
    }
}
