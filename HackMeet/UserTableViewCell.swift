//
//  UserTableView.swift
//  HackMeet
//
//  Created by Matthew Swenson on 4/18/19.
//  Copyright © 2019 Matthew Swenson. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell    {
    
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userLangs: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
