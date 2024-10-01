//
//  ErrorMiddleWare.swift
//  FoursquareClone
//
//  Created by Selim on 26.09.2024.
//

import UIKit

class ErrorMiddleWare: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    func showError(_title : String, _message : String)
    {
       
            let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
            
            let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        
        alert.addAction(action)
            
        if let topController = UIApplication.shared.windows.first?.rootViewController {
                var presentedVC = topController
                while let next = presentedVC.presentedViewController {
                    presentedVC = next
                }
                presentedVC.present(alert, animated: true, completion: nil)
            }
    }
    
    
}
