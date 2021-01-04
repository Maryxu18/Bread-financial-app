//
//  LoginViewController.swift
//  Bread-financial-app
//
//  Created by Amanda on 2020-02-24.
//  Copyright © 2020 Amanda. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    //MARK: Actions
    @IBAction func onClickForgotPassword(_ sender: Any) {
    }
    @IBAction func onClickSignUp(_ sender: UIButton) {
        print("sign up tapped")
    }
    
    @IBAction func onClickLogin(_ sender: UIButton) {
        print("login tapped")
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            errorLabel.text = "Please fill in all fields"
        }
        else {
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    self.errorLabel.text = error!.localizedDescription
                }
                else {
                    self.transitionToHome()
                }
            }
            
        }
    }
}



