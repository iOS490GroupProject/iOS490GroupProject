//
//  LoginViewController.swift
//  FoodMood
//
//  Created by Dhriti Chawla on 3/5/18.
//  Copyright © 2018 iOSGroupProject. All rights reserved.
//

import UIKit
import Parse


class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    let userExistsAlert = UIAlertController(title: "Username Exists", message: "This username already exists", preferredStyle: .alert)
    let invalidAlert = UIAlertController(title: "Invalid username or password ", message: "The username or password is invalid. Please try again.", preferredStyle: .alert)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let OKAction = UIAlertAction(title: "OK", style: .destructive) { (action) in
            
        }
        self.userExistsAlert.addAction(OKAction)
        self.invalidAlert.addAction(OKAction)
        
//        emailField.delegate = self
//        passwordField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInButton(_ sender: Any)
    {
        let username = emailField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
                self.present(self.invalidAlert, animated: true) {
                }
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "tabBar", sender: nil)
            }
        }
        
    }
    
    
    @IBAction func signUpButton(_ sender: Any)
    {
        let newUser = PFUser()
        
        newUser.username = emailField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                if String(describing: error.localizedDescription).contains("Account already exists for this username.") {
                    print("This user already has an account!!")
                    
                    self.present(self.userExistsAlert, animated: true) {
                    }
                }
                
            } else {
                print("User Registered successfully")
                self.performSegue(withIdentifier: "GoToHome", sender: nil)
            }
        }
        
    }
}
