//
//  LoginViewController.swift
//  SnapChat
//
//  Created by Renato Vieira on 6/9/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField:    UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setSecurityAndEntryOfFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func login() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        let login = Auth.auth()
        
        login.signIn(withEmail: email, password: password, completion: {(user, error) in
            if error != nil {
                let errorRecovery = error?.localizedDescription
                var message       = ""
                
                switch errorRecovery {
                    case "The email address is badly formatted.":
                        message = "Invalid email, insert a valid email."
                        
                    case "There is no user record corresponding to this identifier. The user may have been deleted.":
                        message = "There is no user record corresponding to this email. The email may have been deleted."
                    
                    case "The password is invalid or the user does not have a password.":
                        message = "The password is invalid or the user does not have a password."
                        
                    default:
                        Alert(controller: self).showAlertAction("Warning", "Data entered is incorrect.")
                }
                
                Alert(controller: self).showAlertAction("Warning", message)
            } else {
//                func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//                    if segue.identifier == "loginSegue" {
//                        if let viewController = segue.destination as? LoginViewController {
//                            self.present(viewController, animated: true, completion: nil)
//                        }
//                    }
//                }
            }
        })
    }
    
    @IBAction func loginButton(_ sender: Any) {
        self.login()
    }
    
    func setSecurityAndEntryOfFields() {
        self.emailTextField.keyboardType                = .emailAddress
        self.passwordTextField.isSecureTextEntry        = true
    }
}
