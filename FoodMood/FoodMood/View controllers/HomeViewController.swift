//
//  HomeViewController.swift
//  FoodMood
//
//  Created by Simona Virga on 3/21/18.
//  Copyright © 2018 iOSGroupProject. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet var collectionView: UICollectionView!
    

    
    var refresh: UIRefreshControl!
    
    let logoutAlert = UIAlertController(title: "Confirm", message: "Are you sure you want to log out?", preferredStyle: .alert)
    
    var recipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(HomeViewController.didPullToRefresh(_:)), for: .valueChanged)
        collectionView.refreshControl = refresh

        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        
        // Do any additional setup after loading the view.
        let logoutAction = UIAlertAction(title: "Log Out", style: .destructive) { (action) in
            try! Auth.auth().signOut()
            if let storyboard = self.storyboard {
                let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                self.present(vc, animated: false, completion: nil)
            }
            
        }
        
        logoutAlert.addAction(logoutAction)
        logoutAlert.addAction(cancelAction)
        
        fetchRecipes()
        
    }
    

    
    @IBAction func loggedOut(_ sender: Any) {
        present(logoutAlert, animated: true)
        {
        }
        
    }
    
    func fetchRecipes() {
        FoodClient.sharedInstance.getRecipes(success: { (recipes) in
            self.recipes = recipes
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.refresh.endRefreshing()
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchRecipes()
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
        
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        let recipe = recipes[indexPath.row]
        
        cell.recipe = recipe
        return cell
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
            if (segue.identifier == "viewPost") {
            let vc = segue.destination as! PhotoDetailViewController
                print("....goes here.... ")
            let cell = sender as! UICollectionViewCell
            let indexPath = collectionView.indexPath(for: cell)!
            
            let r = recipes[indexPath.row]
            vc.recipes = r
            } else if (segue.identifier == "addPost") {
                let controller = segue.destination as! AddPhotoViewController
            }
    
    
        }
    
   
}
