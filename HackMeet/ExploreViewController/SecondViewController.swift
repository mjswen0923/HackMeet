//
//  SecondViewController.swift
//  HackMeet
//
//  Created by Matthew Swenson on 3/28/19.
//  Copyright © 2019 Matthew Swenson. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var UserSearchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var user = User.sharedUser
    var filteredUsers = [User]()
    
    //for testing
    var users = [User]()
    
    var searchActive : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserSearchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        loadSampleViews()
        // Do any additional setup after loading the view.
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        filteredUsers = users.filter({ (user) -> Bool in
            //this can be modified for a better search algo
            let tmp: String = user.name
            let tmp2: [String] = user.langs
            return tmp.contains(searchText) || tmp2.contains(searchText)
        })
        if(filteredUsers.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filteredUsers.count
        }
        return users.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //Add: when you type in a name that doesnt match anything, show nothing
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell else {
            fatalError("the dequed cell is not an instance of UserTableViewCell")
        }
        
        if(searchActive){
            let user = filteredUsers[indexPath.row]
            cell.userNameLabel.text = user.name
            cell.userLangsLabel.text = user.langs.joined(separator: ", ")
            cell.userCellImage.image = user.proPic
        } else {
            let user = users[indexPath.row]
            cell.userNameLabel.text = user.name
            cell.userLangsLabel.text = user.langs.joined(separator: ", ")
            cell.userCellImage.image = user.proPic
        }
        
        return cell;
    }
    
    private func loadUsers()    {
        //this is where I would load the actual user from the server
    }
    
    
    private func loadSampleViews()  {
        let photo1 = UIImage(named: "user.png")!
        let name1 = "Jerry"
        let langs1 = ["Python", "Swift", "Java"]
        
        let user1 = User(pic: photo1, name: name1, langs: langs1)
        
        let photo2 = UIImage(named: "user.png")!
        let name2 = "Bob"
        let langs2 = ["Racket", "Javascript"]
        
        let user2 = User(pic: photo2, name: name2, langs: langs2)
        
        users += [user1, user2]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

