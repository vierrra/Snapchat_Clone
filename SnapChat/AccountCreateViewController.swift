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
            Auth.auth().createUser(withEmail: email, password: password, completion: {(user, error) in
                if error == nil {
                    Alert(controller: self).showAlertAction("Parabéns", "Usuário registrado com sucesso")
                } else {
                    Alert(controller: self).showAlertAction("Algo deu errado", "Não foi possível cadastrar usuário")
                }
            })
        } else {
            Alert(controller: self).showAlertAction("Aviso", "Senhas não coincidem")
        }
    }
    
    func setSecurityAndEntryOfFields() {
        self.emailTextField.keyboardType                = .emailAddress
        self.passwordTextField.isSecureTextEntry        = true
        self.confirmPasswordTextField.isSecureTextEntry = true
    }
}
