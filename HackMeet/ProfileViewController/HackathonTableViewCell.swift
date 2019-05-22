//
//  HackathonTableViewCell.swift
//  HackMeet
//
//  Created by Matthew Swenson on 5/22/19.
//  Copyright © 2019 Matthew Swenson. All rights reserved.
//

import UIKit

class HackathonTableViewCell: UITableViewCell   {
    
    @IBOutlet var hackathonLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
