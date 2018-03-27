//
//  PhotoCell.swift
//  FoodMood
//
//  Created by Dhriti Chawla on 3/25/18.
//  Copyright © 2018 iOSGroupProject. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var myImage: UIImageView!
    
    var recipe: Recipe! {
        didSet {
            myImage.af_setImage(withURL: URL(string: recipe.picture)!)
        }
    }
}
