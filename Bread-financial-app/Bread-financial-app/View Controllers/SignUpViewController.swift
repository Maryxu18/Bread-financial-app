//
//  SignUpViewController.swift
//  Bread
//
//  Created by Mary Xu on 2020-06-13.
//  Copyright © 2020 Amanda. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var signUpButton: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func validateFields() -> String? {
        //check all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill in all fields"
        }
        //check if the email is valid: checkout https://www.youtube.com/watch?v=1HN7usMROt8 at ~50min... (use regular expressions to match email format"
        return nil
    }
    
    func transitionToLogin() {
        let loginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginViewController
        
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func onClickSignUp(_ sender: Any) {
        //validate the fields
        let error = validateFields()
        if error != nil {
            errorLabel.text = error
        }
        else {
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create the user
            Auth.auth().createUser(withEmail: email, password: passwordTextField.text!) { (result, err) in
                if err != nil {
                    self.errorLabel.text = err!.localizedDescription //for developer/debug use
                    //self.showError("Error creating user") //simplified for user
                }
                else {
                    //user created successfully
                    let db = Firestore.firestore()
                
                db.collection("users").document(result!.user.uid).setData(["firstname":firstName, "lastname":lastName, "categories":[]]) { (error) in
                        
                        if error != nil {
                            self.errorLabel.text = error!.localizedDescription
                        }
                    }
                    
//                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid":result!.user.uid, "categories":{}]) { (error) in
//
//                        if error != nil {
//                            self.errorLabel.text = error!.localizedDescription
//                        }
//                    }
                    //transition back to login page
                    self.transitionToLogin()
                }
            }
        }
    }
}
