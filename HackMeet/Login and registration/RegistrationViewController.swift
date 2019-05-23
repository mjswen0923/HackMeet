//
//  RegistrationViewController.swift
//  HackMeet
//
//  Created by Matthew Swenson on 5/23/19.
//  Copyright © 2019 Matthew Swenson. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase

class RegistrationViewController: UIViewController  {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.backgroundColor = .white
        registerButton.layer.cornerRadius = 5
        registerButton.addTarget(self, action: #selector(addUserData), for: .touchUpInside)
    }
    
    @objc private func addUserData()    {
        guard nameTextField.text?.isEmpty == false else {
            return
        }
        guard emailTextField.text?.isEmpty == false else {
            return
        }
        User.sharedUser.name = nameTextField.text!
        User.sharedUser.email = emailTextField.text!
        let db = FirebaseService.sharedInstance.database.collection("users")
        db.document(User.sharedUser.email.replacingOccurrences(of: "@gmail.com", with: ""))
            .setData(["name": User.sharedUser.name,
                      "email": User.sharedUser.email,
                      "langauges": User.sharedUser.langs,
                      "summary": User.sharedUser.summary,
                      "hackathons": User.sharedUser.hackathons
                ])
        self.performSegue(withIdentifier: "registerToHome", sender: self)
    }
}
