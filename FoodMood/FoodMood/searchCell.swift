//
//  searchCell.swift
//  FoodMood
//
//  Created by Dhriti Chawla on 3/28/18.
//  Copyright © 2018 iOSGroupProject. All rights reserved.
//

import UIKit

class searchCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var recipe: UILabel!
    
    var recipes: Recipe! {
        didSet {
            title.text = recipes.title
            recipe.text = recipes.recipe
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
