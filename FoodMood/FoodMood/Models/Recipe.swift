//
//  Recipe.swift
//  FoodMood
//
//  Created by Dhriti Chawla on 3/26/18.
//  Copyright © 2018 iOSGroupProject. All rights reserved.
//

import UIKit

class Recipe: NSObject {
    
    var picture: String = ""
    var recipe: String = ""
    var username: String = ""
    var title: String = ""
    
    init(recipeInfo: [String: Any]) {
        picture = recipeInfo["Picture"] as! String
        recipe = recipeInfo["Recipe"] as! String
        username = recipeInfo["User"] as! String
        title = recipeInfo["Title"] as! String
    }
    
//    if (!AllVariables.recs.contains(recipe)) {
//    AllVariables.recs.append(recipe) }
}
