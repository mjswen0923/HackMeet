//
//  FirebaseService.swift
//  HackMeet
//
//  Created by Matthew Swenson on 5/21/19.
//  Copyright © 2019 Matthew Swenson. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class FirebaseService   {
    
    static var sharedInstance = FirebaseService()
    
    var database: Firestore!
    var storage: Storage!
    
    init()  {
        FirebaseApp.configure()
        database = Firestore.firestore()
        storage = Storage.storage()
    }
}
