//
//  ProfileViewController.swift
//  FoodMood
//
//  Created by Simona Virga on 3/21/18.
//  Copyright © 2018 iOSGroupProject. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
   
    let logoutAlert = UIAlertController(title: "Confirm", message: "Are you sure you want to log out?", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let logoutAction = UIAlertAction(title: "Log Out", style: .destructive) { (action) in
            NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        logoutAlert.addAction(logoutAction)
        logoutAlert.addAction(cancelAction)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loggedOut(_ sender: Any) {
        
        present(logoutAlert, animated: true)
        {
        }
    }
    
}
