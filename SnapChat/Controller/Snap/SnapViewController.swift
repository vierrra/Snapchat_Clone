//
//  SnapViewController.swift
//  SnapChat
//
//  Created by Renato on 6/11/21.
//

import UIKit
import Firebase

class SnapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func logOffButton(_ sender: Any) {
        
        self.alertLoggOfUser()
    }
   
    func loggOfUser() {
        let logOff = Auth.auth()
        do{
            try logOff.signOut()
            self.performSegue(withIdentifier: "logOffSegue", sender: nil)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func alertLoggOfUser() {
        let alert    = UIAlertController(title: "Warning", message: "Do you want to logoff?", preferredStyle: .alert)
        let okCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: { (_) in
            
            self.loggOfUser()
        })
        
        alert.addAction(okButton)
        alert.addAction(okCancel)
        
        self.present(alert, animated: true, completion: nil)
    }
}
