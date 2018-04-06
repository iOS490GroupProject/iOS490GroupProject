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


class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var userUid: String!

    override func viewDidLoad()
    {
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
            //print("...here.....")
            Auth.auth().signIn(withEmail: email, password: password, completion: {(user,error) in
                if (error == nil) {
                   // print ("......null error?....")
                    if let user = user {
                        let databaseRef = Database.database().reference();
                        let userID = Auth.auth().currentUser!.uid
                        AllVariables.uid = userID
                        print(userID)
                        
                        databaseRef.child("Users").child("UserDetails").observeSingleEvent(of: DataEventType.value, with: { snapshotA in
                            if snapshotA.hasChild(AllVariables.uid) {
                                 databaseRef.child("Users").child("UserDetails").child(AllVariables.uid).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                                    print("HERE")
                                  
                                    let value = snapshotB.value as? NSDictionary
                                    AllVariables.Username = value?["Username"] as? String ?? ""
                                    AllVariables.Fname = value?["Fname"] as? String ?? ""
                                    AllVariables.Lname = value?["Lname"] as? String ?? ""
                                    AllVariables.Bio = value?["Bio"] as? String ?? ""
                                    AllVariables.profpic = value?["profile_pic"] as? String ?? ""
//                                    databaseRef.child("Users").child("Student").child(AllVariables.uid).child("Courses").observeSingleEvent(of: DataEventType.value, with: { (snapshotCourse) in
//                                        let counter = 0;
//                                        let enumer = snapshotCourse.children
////                                        while let rest = enumer.nextObject() as? DataSnapshot {
////                                            AllVariables.courses.append(rest.value as! String)
////                                        }
//                                    })
                                    
                                })
                                self.userUid = user.uid
                                self.performSegue(withIdentifier: "signingIn", sender: self)
                            }
                    
                        })
                    }
                }         else {
                    let alert = UIAlertController(title: "Sign in error", message: "error signing in", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        print ("ok tappped")
                    }
                    alert.addAction(OKAction)
                    self.present(alert, animated: true) {
                        print("ERROR")
                    }
                    print("error signing in \(error)")
                }
            })
        }

        
    }
    
    
    @IBAction func signUpButton(_ sender: Any)
    {
     
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (user,error) in
            if error != nil
            {
                let alert = UIAlertController(title: "Error", message: "can not create user", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    print ("ok tappped")
                }
                
                alert.addAction(OKAction)
                self.present(alert, animated: true) {
                    print("ERROR")
                }
                print("can not create user \(error)")
            }
            else
            {
                if let user = user
                {
                    self.userUid = user.uid
                    print (".....!!!!!!....\(self.userUid)....")
                    
                    let changeRequest = user.createProfileChangeRequest()
                    
                    changeRequest.displayName = self.emailField.text
                    
                    changeRequest.commitChanges { error in
                        if let error = error
                        {
                            let alert = UIAlertController(title: "Error", message: "error registering user", preferredStyle: .alert)
                            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                                print ("ok tappped")
                            }
                            alert.addAction(OKAction)
                            self.present(alert, animated: true) {
                                print("ERROR")
                            }
                            print("error registering user")
                            print(error)
                            
                        }
                        else
                        {
                            print("Success registering user!")
                            self.performSegue(withIdentifier: "goToHome", sender: self)
                        }
                    }
                }
            }
            
        })

        
    }
    
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    
}
