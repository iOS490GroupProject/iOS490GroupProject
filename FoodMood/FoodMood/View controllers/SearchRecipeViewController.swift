//
//  SearchRecipeViewController.swift
//  FoodMood
//
//  Created by Dhriti Chawla on 3/25/18.
//  Copyright © 2018 iOSGroupProject. All rights reserved.
//

import UIKit

class SearchRecipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet var tableView: UITableView!
    
    
    let searchBar = UISearchBar()
    var courseData = [[String: AnyObject]]()
  //  var titles: [Recipe] = []
    var recipes: [Recipe] = []
    
    // var numbers = [String]()
    
    var filteredArrayName: [Recipe] = []
    var showSearchResults = false
    
    var refresh: UIRefreshControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
        

        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(SearchRecipeViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableView.insertSubview(refresh, at: 0)
        
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        fetchData()
        
        
        
    }
    
    func fetchData() {
        FoodClient.sharedInstance.getRecipes(success: { (recipes) in
            self.recipes = recipes
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refresh.endRefreshing()
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        
    }
    
    func createSearchBar() {
        
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search an ingredient...."
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let mySearch = searchBar.text!
//        filteredArrayName = names.filter({( name: String) -> Bool in
//            return name.lowercased().range(of:searchText.lowercased()) != nil
//        })
        
        
        if searchBar.text == "" {
            showSearchResults = false
            self.tableView.reloadData()
        } else {
            showSearchResults = true
            self.tableView.reloadData()
        }
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        showSearchResults = true
        searchBar.endEditing(true)
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        self.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (showSearchResults) {
            return filteredArrayName.count
        }
        else {
            return recipes.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! searchCell
        
        if (showSearchResults){
            
            let nam = filteredArrayName[indexPath.row]
            //cell.recipes = nam
            
        }
        else {
            let rec = recipes[indexPath.row]
            cell.recipes = rec
        }
        return cell
    }
    

}
