//
//  FourthViewController.swift
//  HackMeet
//
//  Created by Matthew Swenson on 3/28/19.
//  Copyright © 2019 Matthew Swenson. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var settingsTableView: UITableView!
    
    var table = [SettingsViewCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateTable()
    }
    
    func populateTable()  {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return table[indexPath.row]
    }
}
