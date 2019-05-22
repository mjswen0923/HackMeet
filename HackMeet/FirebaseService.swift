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

class FirebaseService   {
    static var sharedInstance = FirebaseService()
    
    init()  {
        FirebaseApp.configure()
    }
}
