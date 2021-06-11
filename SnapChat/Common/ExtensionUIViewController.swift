//
//  ExtensionUIViewController.swift
//  SnapChat
//
//  Created by Renato Vieira on 6/10/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentFullScreen(_ viewControllerToPresent: UIViewController,
                               animated flag:             Bool,
                               completion:                (() -> Swift.Void)? = nil) {
            viewControllerToPresent.modalPresentationStyle = .fullScreen
            self.present(viewControllerToPresent,
                         animated:   flag,
                         completion: completion)
        }
}
