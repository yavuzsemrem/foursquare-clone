//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Selim on 25.09.2024.
//

import UIKit
import Parse

class SignUpController: UIViewController {
    
    @IBOutlet weak var nameLabel: UITextField!
    
    @IBOutlet weak var mailLabel: UITextField!
    
    @IBOutlet weak var passwordLabel: UITextField!
    
    @IBOutlet weak var indicatorSignup: UIActivityIndicatorView!

    var error = ErrorMiddleWare()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
  
    @IBAction func signUpClicked(_ sender: UIButton) {
        
        let user = PFUser()
        
        
        //Check all the if statements at the same time and gives the one error
        guard let _user =  nameLabel.text , !_user.isEmpty,
             let _email = mailLabel.text, !_email.isEmpty,
              let _password = passwordLabel.text, !_password.isEmpty else
        {
            self.error.showError(_title: "Eksik Bilgi", _message: "Tüm alanları doldurunuz")
            return
        }
        
        
        user.username = nameLabel.text
        user.email = mailLabel.text
        user.password = passwordLabel.text
        
        if let indicator = self.indicatorSignup {
            indicator.startAnimating()
        } else {
            print("indicatorSignup is nil")
        }

        user.signUpInBackground { success, _error in
            
            if let _indicator = self.indicatorSignup {
                _indicator.stopAnimating()
            } else {
                print("indicatorSignup is nil")
            }
            
            if _error != nil {
                self.error.showError(_title: "Error", _message: "\(String(describing: _error?.localizedDescription))")
            }
            else {
                self.performSegue(withIdentifier: "toSignInVC", sender: self)
                print("User successfuly created")
            }
        }
        
    }
    
    
    @IBAction func signInClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toSignInVC", sender: self)
        
    }
}

