//
//  HomeViewController.swift
//  Bread
//
//  Created by Mary Xu on 2020-05-01.
//  Copyright © 2020 Amanda. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var categoryLimitTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickAddCategory(_ sender: Any) {
        if categoryTextField.text?.trimmingCharacters(in: .newlines) == "" || categoryLimitTextField.text?.trimmingCharacters(in: .newlines) == "" {
            welcomeLabel.text = "Please fill in all fields"
        }
        else {
            let category = "category." + categoryTextField.text!
            let limit = categoryLimitTextField.text!
            
            categoryTextField.text = ""
            categoryLimitTextField.text = ""
            
            let db = Firestore.firestore()
            let user = Auth.auth().currentUser

            db.collection("users").document(user!.uid).updateData([category: limit]) { (error) in
                
                if error != nil {
                    self.welcomeLabel.text = error!.localizedDescription
                }
            }
        }
    }
}



