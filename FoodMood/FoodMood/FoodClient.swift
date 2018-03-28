//
//  FoodClient.swift
//  FoodMood
//
//  Created by Dhriti Chawla on 3/26/18.
//  Copyright © 2018 iOSGroupProject. All rights reserved.
//

import Firebase

class FoodClient {
    static let sharedInstance = FoodClient()
    
    let recipeRef = Database.database().reference().child("Recipes")
    let recipeImageRef = Storage.storage().reference().child("RecipeImages")
    let userRef = Database.database().reference().child("Users").child("UserDetails")
    
    
    func createRecipe(picture:UIImage, title:String, recipe:String, success: @escaping  (Recipe)->(), failure: @escaping  (Error)->()) {
        var recipeInfo = ["Title": title, "Recipe": recipe]
        
        recipeInfo["User"] = Auth.auth().currentUser!.uid
        let uid = UUID().uuidString
        
        if let imageData = UIImagePNGRepresentation(picture) {
            
            let profilePicStorageRef = recipeImageRef.child(uid)
            
            let uploadTask = profilePicStorageRef.putData(imageData as Data, metadata: nil) { metadata, error in
                if let error = error {
                    failure(error)
                } else if let metadata = metadata {
                    let downloadURL = metadata.downloadURL()
                    recipeInfo["Picture"] = downloadURL!.absoluteString
                    
                    self.recipeRef.child(uid).setValue(recipeInfo, withCompletionBlock: { (error, ref) in
                        if let error = error {
                            failure(error)
                        } else {
                            success(Recipe(recipeInfo: recipeInfo))
                        }
                    })
                    
                }
            }
        }
        
    }
    
    
    func getRecipes(success: @escaping  ([Recipe])->(), failure: @escaping  (Error)->()){
        
        recipeRef.observe(.value, with: { (snapshot) in
            
            if let recipesData = snapshot.value as? [String: [String: Any]] {
                
                var recipes: [Recipe] = []
                
                for (key, recipeData) in recipesData {
                    let recipe = Recipe(recipeInfo: recipeData)
                    recipes.append(recipe)
                }
                
                success(recipes)
                
            } else {
                success([])
            }
            
        }) { (error) in
            failure(error)
        }
    }
    
    func getUser(success: @escaping  ([Recipe])->(), failure: @escaping  (Error)->())
    {
        
        
    }
    
}


