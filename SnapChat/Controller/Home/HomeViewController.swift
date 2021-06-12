//
//  HomeViewController.swift
//  SnapChat
//
//  Created by Renato Vieira on 6/9/21.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkIfUserLoggedIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func checkIfUserLoggedIn() {
        Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let loggedInUser = user {
                self.performSegue(withIdentifier: "loginAutomaticSegue", sender: nil)
            } else {
                print("Usuário não logado")
            }
        })
    }
}

