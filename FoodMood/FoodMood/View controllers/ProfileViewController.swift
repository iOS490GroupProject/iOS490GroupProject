//
//  ProfileViewController.swift
//  FoodMood
//
//  Created by Simona Virga on 3/21/18.
//  Copyright © 2018 iOSGroupProject. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController {
   
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var navBar: UINavigationItem!
    var loggedInUser: AnyObject?
    var databaseRef = Database.database().reference()
    var storageRef = Storage.storage().reference()
    var image: UIImageView!
    
    @IBOutlet weak var updateBioText: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    
    
    let logoutAlert = UIAlertController(title: "Confirm", message: "Are you sure you want to log out?", preferredStyle: .alert)
    
    func setProfilePicture(imageView:UIImageView, imageToSet:UIImage)
    {
        imageView.layer.cornerRadius = 10.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = true
        imageView.image = imageToSet
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navBar.title = "\(AllVariables.Username)"
        
        let logoutAction = UIAlertAction(title: "Log Out", style: .destructive) { (action) in
            try! Auth.auth().signOut()
            if let storyboard = self.storyboard {
                let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! UIViewController
                self.present(vc, animated: false, completion: nil)
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        logoutAlert.addAction(logoutAction)
        logoutAlert.addAction(cancelAction)
        
        user.text = AllVariables.Username
        Name.text = "\(AllVariables.Fname) \(AllVariables.Lname)"
        user.text = "@\(AllVariables.Username)"
        //bio.text = AllVariables.Bio
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateBioText.text = AllVariables.Bio
        var databaseProfilePic = AllVariables.profpic
        let data = NSData(contentsOf: NSURL(string: databaseProfilePic)! as URL)
        if (AllVariables.profpic != "") {
            setProfilePicture(imageView: self.profilePic,imageToSet:UIImage(data: data! as Data)!)
        }

    }

    @IBAction func loggedOut(_ sender: Any) {
        
        present(logoutAlert, animated: true)
        {
        }
    }
    
}
