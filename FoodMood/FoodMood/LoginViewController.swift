//
//  LoginViewController.swift
//  FoodMood
//
//  Created by Dhriti Chawla on 3/5/18.
//  Copyright © 2018 iOSGroupProject. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn


class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInButton(_ sender: Any)
    {
        
        if let email = emailField.text, let password = passwordField.text
        {
            //Auth.auth().signIn(with: <#T##AuthCredential#>, completion: <#T##AuthResultCallback?##AuthResultCallback?##(User?, Error?) -> Void#>)
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                
                if let u = user
                {
                    self.performSegue(withIdentifier: "tabBar" , sender: self)
                }
                else
                {
                    
                }
                
            }
        }
        
        
    }
    
    
    @IBAction func signUpButton(_ sender: Any)
    {
        //Auth.auth().createUser(withEmail: <#T##String#>, password: <#T##String#>, completion: <#T##AuthResultCallback?##AuthResultCallback?##(User?, Error?) -> Void#>)
        
        if let email = emailField.text, let password = passwordField.text
        {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                
                if let u = user
                {
                    
                }
                else
                {
                    
                }
                
            }
        }
        
    }
}
