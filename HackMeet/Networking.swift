//
//  Networking.swift
//  HackMeet
//
//  Created by Matthew Swenson on 4/30/19.
//  Copyright © 2019 Matthew Swenson. All rights reserved.
//

import Foundation
import SwiftyJSON

class Networking    {
    
    var credential: URLCredential
    let url = "https://test-website.com/"
    
    public init(username: String, password: String)   {
        self.credential = URLCredential(user: username, password: password, persistence: .forSession)
    }
    
    public func setNewCredentials(username: String, password: String)   {
        
    }
}
