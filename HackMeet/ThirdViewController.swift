//
//  ThirdViewController.swift
//  HackMeet
//
//  Created by Matthew Swenson on 4/17/19.
//  Copyright © 2019 Matthew Swenson. All rights reserved.
//

import UIKit

class ThirdViewController: UITableViewController {
    
    var users = [User]()
    var selectedUser = User()
            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadViews()
        
        loadSampleViews()
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
        
        cell.userName.text = user.name
        cell.userImage.image = user.proPic
        
        selectedUser = user
        
        return cell
    }
    
    func loadViews()    {
        //This is where I would load the JSON from the actual users
    }
    
    private func loadSampleViews()  {
        let photo1 = UIImage(named: "user.png")!
        let name1 = "Jerry"
        let langs2 = ["Python, 5", "Java, 0"]
        
        let user1 = User(pic: photo1, name: name1, langs: langs2)
        
        let photo2 = UIImage(named: "user.png")!
        let name2 = "Bob"
        
        let user2 = User(pic: photo2, name: name2, langs: langs2)
        
        users += [user1, user2]
    }
    
    
}
