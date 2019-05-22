//
//  User.swift
//  HackMeet
//
//  Created by Matthew Swenson on 4/15/19.
//  Copyright © 2019 Matthew Swenson. All rights reserved.
//

import UIKit

class User  {
    var name: String = ""
    
    var langs = [String]()
    var hackathons = [String]()
    var summary = ""
    var email = ""
    var id: Int? = nil
    var checksum: String? = nil
    var numHacks: Int? = 0
    var proPic = UIImage()
    var chatColor = UIColor()
    var contactList = [User]()
    
    static var sharedUser = User()
    
    public init() {}

    init(pic: UIImage, name: String, langs: [String])   {
        self.proPic = pic
        self.name = name
        self.langs = langs
    }
    
    func addContact(user: User) {
        contactList.append(user)
    }
    
//    func removeContact(user: User)  {
//        contactList = contactList.filter{ $0 != user}
//    }
}
