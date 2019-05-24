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
    var username: String = ""
    var langs = [String]()
    var hackathons = [String]()
    var summary = ""
    var email = ""
    var id: String = ""
    var checksum: String = ""
    var numHacks: Int = 0
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
    
    func updateUser() {
        let db = FirebaseService.sharedInstance.database.collection("users").document(User.sharedUser.email.replacingOccurrences(of: "@gmail.com", with: ""))
        db.setData(["name" : User.sharedUser.name,
                    "email": User.sharedUser.email,
                    "langauges": User.sharedUser.langs,
                    "summary" : User.sharedUser.summary,
                    "hackathons" : User.sharedUser.hackathons])
    }
}
