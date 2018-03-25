//
//  PhotoDetailViewController.swift
//  FoodMood
//
//  Created by Dhriti Chawla on 3/25/18.
//  Copyright © 2018 iOSGroupProject. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var recipe: UILabel!
    @IBOutlet weak var myTitle: UILabel!
    
    var t: String = ""
    var r: String = ""
    var u: String = ""
    var p: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        username.text = u
        recipe.text = r
        myTitle.text = t
        
        let data = NSData(contentsOf: NSURL(string: p)! as URL)
        photo.image = UIImage(data: data! as Data)!
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
