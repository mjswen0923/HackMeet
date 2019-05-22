//
//  UserTableView.swift
//  HackMeet
//
//  Created by Matthew Swenson on 4/18/19.
//  Copyright © 2019 Matthew Swenson. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell    {
    
    @IBOutlet var userCellImage: UIImageView!
    @IBOutlet var userLangsLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
