//
//  DetailsViewController.swift
//  FoodMood
//
//  Created by Dhriti Chawla on 3/21/18.
//  Copyright © 2018 iOSGroupProject. All rights reserved.
//

import UIKit

import Firebase
import FirebaseAuth

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var Fname: UITextField!
    @IBOutlet weak var Lname: UITextField!
    @IBOutlet weak var user: UITextField!
    
    @IBOutlet weak var bio: UITextView!
    var ref: DatabaseReference!
    var userN = String()
    var LN = String()
    var FN = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitDetails(_ sender: Any) {
        if Fname.text == "" {
            let Empty = UIAlertController(title: "Error", message: "Please enter your first name", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .destructive) { (action) in
        }
            Empty.addAction(OKAction)
            self.present(Empty, animated: true) {
            }
            
        } else if Lname.text == "" {
            let Empty = UIAlertController(title: "Error", message: "Please enter your last name", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .destructive) { (action) in
            }
            Empty.addAction(OKAction)
            self.present(Empty, animated: true) {
            }
            
        } else if user.text == "" {
            let Empty = UIAlertController(title: "Error", message: "Please enter your username", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .destructive) { (action) in
            }
            Empty.addAction(OKAction)
            self.present(Empty, animated: true) {
            }
            
        } else  {
            
            AllVariables.Fname = Fname.text!
            AllVariables.Lname = Lname.text!
            AllVariables.Bio = bio.text!
            
            /////
            let databaseRef = Database.database().reference();
            let userID = Auth.auth().currentUser!.uid
            AllVariables.uid = userID
            databaseRef.child("Users").observeSingleEvent(of: DataEventType.value, with: { (snapshotUsernames) in
                if snapshotUsernames.hasChild(self.user.text!) {
                    let alert = UIAlertController(title: "Error", message: "Username taken!", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        print ("ok tappped")
                    }
                    alert.addAction(OKAction)
                    self.present(alert, animated: true) {
                        print("ERROR")
                    }
                }
                else {
                print (AllVariables.Username)
                    print ("...........")
                    print(self.user.text)
                    self.ref.child("Users").child("Usernames").child(self.user.text!).setValue("-")
                
                    self.ref.child("Users").child("UserDetails").child(AllVariables.uid).setValue(["Username": self.user.text!, "Fname": self.Fname.text!, "Lname": self.Lname.text!, "Bio": self.bio.text ?? ""])
                self.FN = self.Fname.text!
                self.LN = self.Lname.text!
                
                    
                    
                AllVariables.Username = self.user.text!
                AllVariables.Fname = self.Fname.text!
                    AllVariables.Lname = self.Lname.text!
                
                
                }
                
            }
            )
            
            /////
        
            self.performSegue(withIdentifier: "Next", sender: nil)
        }
    }
    
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    

}
