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
 
    var photoTitle = [String]()
    var photoImage = [String]()
    var photoUser = [String]()
    var photoRecipe = [String]()


    var refresh: UIRefreshControl!
    let ref = Database.database().reference()
    
    let logoutAlert = UIAlertController(title: "Confirm", message: "Are you sure you want to log out?", preferredStyle: .alert)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(HomeViewController.didPullToRefresh(_:)), for: .valueChanged)
        
         collectionView.insertSubview(refresh, at: 0)
        
        fetchData()

        // Do any additional setup after loading the view.
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
  
        fetchData()
        
        collectionView.reloadData()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func fetchData () {
        var counter = 0;
        ref.child("RecipePictures").observeSingleEvent(of: DataEventType.value, with: { snapshotA in
       
            let enumer = snapshotA.children
            while let rest = enumer.nextObject() as? DataSnapshot {
                let a = "Photo\(counter)"
                
                self.ref.child("RecipePictures").child(a).observeSingleEvent(of: DataEventType.value, with: { snapshotB in
                    
                    
                    //Book Details
                    let value = snapshotB.value as? NSDictionary
                    
                    if (!self.photoTitle.contains(value?["Title"] as! String)){
                        //print (self.photoImage)
                        self.photoTitle.append(value?["Title"] as? String ?? "")
                        self.photoImage.append(value?["Photo"] as? String ?? "")
                        self.photoUser.append(value?["Username"] as? String ?? "")
                        self.photoRecipe.append(value?["Recipe"] as? String ?? "")
                    }
                })
                
                counter += 1
                
            }
            self.collectionView.reloadData()
            //self.refresh.endRefreshing()
            
        })
        
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
    

    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchData()
    }

    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            print ("..!.@.\(photoTitle.count)")
            return photoTitle.count
            //return 3
        
        }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
            let nam = photoImage[indexPath.row]
            let data = NSData(contentsOf: NSURL(string: nam)! as URL)
            cell.myImage.image = UIImage(data: data! as Data)!

            return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let vc = segue.destination as! PhotoDetailViewController
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!


            let t = photoTitle[indexPath.row]
            vc.t = t
            let u = photoUser[indexPath.row]
            vc.u = u
            let r = photoRecipe[indexPath.row]
            vc.r = r
            let p = photoImage[indexPath.row]
            vc.p = p
        
        


    }
    
}
