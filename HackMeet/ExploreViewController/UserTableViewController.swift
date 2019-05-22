//
//  UserTableViewController.swift
//  HackMeet
//
//  Created by Matthew Swenson on 4/18/19.
//  Copyright © 2019 Matthew Swenson. All rights reserved.
//

import UIKit
import os.log

class UserTableViewController: UITableViewController   {
    
    var users = [User]()
    var selectedUser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleViews()
        
        loadViews()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)   {
        if segue.destination is ChatViewController  {
            let vc = segue.destination as! ChatViewController
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell else {
            fatalError("the dequed cell is not an instance of UserTableViewCell")
        }
        
        let user = users[indexPath.row]
        
        cell.userNameLabel.text = user.name
        cell.userLangsLabel.text = user.langs.joined(separator: ", ")
        cell.userCellImage.image = user.proPic
        
        selectedUser = user
        
        return cell
    }
    
    func loadViews()    {
        //This is where I would load the JSON from the actual users
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
    
}
