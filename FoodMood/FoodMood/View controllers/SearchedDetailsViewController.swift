//
//  SearchedDetailsViewController.swift
//  FoodMood
//
//  Created by Dhriti Chawla on 3/25/18.
//  Copyright © 2018 iOSGroupProject. All rights reserved.
//

import UIKit
import Firebase

class SearchedDetailsViewController: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var recipe: UILabel!
    @IBOutlet weak var myTitle: UILabel!
    let usernameRef = Database.database().reference().child("Users").child("UserDetails")
    
    var user: String = ""
    var recipes: Recipe!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //username.text = recipes.username
        
        usernameRef.child(recipes.username).child("Username").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let item = snapshot.value as? String{
                //print ("inside here.....")
                self.username.text = item
            }
        })
        print(self.user)
        
        recipe.text = recipes.recipe
        myTitle.text = recipes.title
        photo.af_setImage(withURL: URL(string: recipes.picture)! )
        
    }

}
