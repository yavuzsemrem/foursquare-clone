//
//  SignInController.swift
//  FoursquareClone
//
//  Created by Selim on 26.09.2024.
//

import UIKit
import Parse

class SignInController: UIViewController {

    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var userLabel: UITextField!

    var _error = ErrorMiddleWare()
    var defaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        We can't use userDefaults here 'cause the app works first then the controller seems.
//        if we use userDefaults here we're gonna see the sign in view first then it'll redirect to Places Page so we gotta use it in SceneDelegete.
//        
//        if defaults.bool(forKey: "isLoggedIn") == true {
//            //if it's true it'll automaticly open list controller
//            print("User already logged in")
//            DispatchQueue.main.async {
//                self.performSegue(withIdentifier: "toListVC", sender: self)
//            }
//        }
        
    }
    
  /*  override func viewDidAppear(_ animated: Bool) {
   
   What is diffrence between ViewDidLoad() and ViewDidAppear() ?
   
   - ViewDidLoad()
   Code works before ui elements seemed
   
   - ViewDidAppear()
   - first ui elements seems then code works
   
   
    }*/

    @IBAction func signInClicked(_ sender: UIButton) {
        
        PFUser.logInWithUsername(inBackground: userLabel.text!, password: passwordLabel.text!) { (user : PFUser?, error : Error? ) in
            if user != nil {
                
                self.defaults.set(true, forKey: "isLoggedIn")
                self.defaults.set(user?.username, forKey: "userName")
                self.defaults.set(user?.password, forKey: "password")
                self.defaults.synchronize()
                
                self.performSegue(withIdentifier: "toListVC", sender: self)
            }
            
            else {
                self._error.showError(_title: "Başarısız İşlem", _message: "\(String(describing: error?.localizedDescription))")
            }
        }
        
        
        
    }
    
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "toSignUpVC", sender: self)
    }
}
