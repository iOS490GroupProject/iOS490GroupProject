//
//  PhotoDetailViewController.swift
//  FoodMood
//
//  Created by Dhriti Chawla on 3/25/18.
//  Copyright © 2018 iOSGroupProject. All rights reserved.
//

import UIKit
import Firebase
import AlamofireImage
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class PhotoDetailViewController: UIViewController {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var recipe: UILabel!
    @IBOutlet weak var myTitle: UILabel!

    
    var recipes: Recipe!
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        print(recipes.username)
        username.text = recipes.username
        recipe.text = recipes.recipe
        myTitle.text = recipes.title
        photo.af_setImage(withURL: URL(string: recipes.picture)! )
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
