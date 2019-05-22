//
//  AppDelegate.swift
//  HackMeet
//
//  Created by Matthew Swenson on 3/28/19.
//  Copyright © 2019 Matthew Swenson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import KeychainSwift
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let keychain = KeychainSwift()
    
    override init() {
        super.init()
        _ = FirebaseService.sharedInstance
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
                
        guard let email = keychain.get("email") else {
            let viewToPresent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginView")
            self.window?.rootViewController = viewToPresent
            return true
        }
        
        guard let password = keychain.get("password") else {
            let viewToPresent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginView") as! LoginViewController
            self.window?.rootViewController = viewToPresent
            return true
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                let viewToPresent = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                self.window?.rootViewController = viewToPresent
            }
            else    {
                let viewToPresent = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginView") as! LoginViewController
                self.window?.rootViewController = viewToPresent
            }
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

