//
//  ProfileLangTableCellView.swift
//  HackMeet
//
//  Created by Matthew Swenson on 4/29/19.
//  Copyright © 2019 Matthew Swenson. All rights reserved.
//

import UIKit

class ProfileLangTableViewCell: UITableViewCell    {
    
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var experienceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
