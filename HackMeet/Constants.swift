//
//  Constants.swift
//  HackMeet
//
//  Created by Matthew Swenson on 5/23/19.
//  Copyright © 2019 Matthew Swenson. All rights reserved.
//

import Firebase

struct Constants
{
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
}
