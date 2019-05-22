//
//  LoginViewController.swift
//  HackMeet
//
//  Created by Matthew Swenson on 5/3/19.
//  Copyright © 2019 Matthew Swenson. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManager
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var noAccountButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.backgroundColor = .white
        loginButton.layer.cornerRadius = 5
        loginButton.addTarget(self, action:#selector(handleLogin), for: .touchUpInside)
        noAccountButton.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
    }
    
    @objc func handleRegistration() {
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!){ (user, error) in
            if error == nil{
                self.performSegue(withIdentifier: "loginToHome", sender: self)
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @objc func handleLogin()    {
        print("clicked the login button")
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
            if error == nil{
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarView")
                self.present(vc, animated: true, completion: nil)
            }
            else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func didLoginSucessfully(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarView")
        self.present(vc, animated: true, completion: nil)
    }
}
