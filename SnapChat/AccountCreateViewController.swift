//
//  AccountCreateViewController.swift
//  SnapChat
//
//  Created by Renato on 6/9/21.
//

import UIKit
import Firebase

class AccountCreateViewController: UIViewController {

    @IBOutlet weak var emailTextField:           UITextField!
    @IBOutlet weak var passwordTextField:        UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setSecurityAndEntryOfFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func accountCreateButton(_ sender: Any) {
        self.userCreateAccount()
    }
    
    func userCreateAccount() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text else { return }
        
        if (password == confirmPassword) {
            let createUser = Auth.auth()
            
            createUser.createUser(withEmail: email, password: password, completion: {(user, error) in
                if error == nil {
                    Alert(controller: self).showAlertAction("Congratulations", "User registered with success.")
                } else {
                    let errorRecovery = error?.localizedDescription
                    var errorMessage = ""
                    
                    switch errorRecovery {
                        case "The email address is badly formatted.":
                            errorMessage = "Invalid email, insert a valid email."
                        
                        case "The password must be 6 characters long or more.":
                            errorMessage = "Password must be at least 6 characters."
                        
                        case "The email address is already in use by another account.":
                            errorMessage = "This email is being used by another account."
                        
                    default:
                        Alert(controller: self).showAlertAction("Warning", "Data entered is incorrect.")
                    }
                    
                    Alert(controller: self).showAlertAction("Warning", errorMessage)
                }
            })
        } else {
            Alert(controller: self).showAlertAction("Warning", "Passwords do not match.")
        }
    }
    
    func setSecurityAndEntryOfFields() {
        self.emailTextField.keyboardType                = .emailAddress
        self.passwordTextField.isSecureTextEntry        = true
        self.confirmPasswordTextField.isSecureTextEntry = true
    }
    
    func setButtonLayout() {
        // to-do
    }
}
