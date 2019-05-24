//
//  FirstViewController.swift
//  HackMeet
//
//  Created by Matthew Swenson on 3/28/19.
//  Copyright © 2019 Matthew Swenson. All rights reserved.
//

import UIKit
import SwiftyJSON
import FirebaseDatabase
import Firebase
import FirebaseFirestore

class FirstViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var ProfilePicButton: UIButton!
    @IBOutlet var ProfilePicView: UIImageView!
    @IBOutlet var ProfileNameLabel: UILabel!
    @IBOutlet var ProfileSummaryTextView: UITextView!
    @IBOutlet var ProfileScreenScrollView: UIScrollView!
    @IBOutlet var languageTableView: UITableView!
    @IBOutlet var hackathonTableView: UITableView!
    @IBOutlet var langsLabel: UILabel!
    @IBOutlet var hackathonsLabel: UILabel!
    @IBOutlet var langAddButton: UIButton!
    
    let imagePicker =  UIImagePickerController()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.languageTableView.invalidateIntrinsicContentSize()
        self.hackathonTableView.invalidateIntrinsicContentSize()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        ProfileSummaryTextView.delegate = self
        
        languageTableView.delegate = self
        languageTableView.dataSource = self
        
        hackathonTableView.delegate = self
        hackathonTableView.dataSource = self
        
        ProfilePicButton.layer.borderColor = (UIColor.init(red: 255/255, green: 150/255, blue: 150/255, alpha: 1)).cgColor
        ProfilePicButton.layer.borderWidth = 5
        ProfilePicButton.layer.cornerRadius = 10
        ProfilePicButton.clipsToBounds = true
        ProfilePicButton.addTarget(self, action: #selector(self.picTouched(_:)), for: .touchUpInside)
        
        loadUser()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)    {
        print("editing")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        User.sharedUser.summary = textView.text!
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == languageTableView ? User.sharedUser.langs.count : User.sharedUser.hackathons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == languageTableView   {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileLangTableViewCell", for: indexPath) as? ProfileLangTableViewCell else {
                fatalError("the dequed cell is not an instance of ProfileLangTableViewCell")
            }
            let lang = User.sharedUser.langs[indexPath.row]
            
            cell.languageLabel.text = String(lang.split(separator: ",")[0])
            cell.experienceLabel.text = String(lang.split(separator: ",")[1])
            
            return cell
        }
        else if tableView == hackathonTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HackathonTableViewCell", for: indexPath) as? HackathonTableViewCell else {
                fatalError("the dequed cell is not an instance of HackathonTableViewCell")
            }
            let hackathon = User.sharedUser.hackathons[indexPath.row]
            
            cell.hackathonLabel.text = hackathon
            
            return cell
        }
        
        //we should never get here
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && tableView == languageTableView {
            User.sharedUser.langs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            User.sharedUser.updateUser()
        } else if editingStyle == .delete && tableView == hackathonTableView    {
            User.sharedUser.hackathons.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            User.sharedUser.updateUser()
        }
    }
    
    @IBAction func langButtonTouched(_ sender: Any) {
        let alert = UIAlertController(title: "Add Language", message: "Enter your language and years of experience", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = "Language:"
        }
        
        alert.addTextField { (textField) in
            textField.text = "Years of experience:"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let langTextField = alert?.textFields![0].text
            let experienceTextField = alert?.textFields![1].text
            User.sharedUser.langs.append(langTextField! + ", " + experienceTextField!)
            self.languageTableView.reloadData()
            User.sharedUser.updateUser()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func hackathonAddButton(_ sender: Any) {
        let alert = UIAlertController(title: "Add Hackathon", message: "Enter a hackathon that you've been to", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = "Hackathon:"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let hackathonTextField = alert?.textFields![0].text
            User.sharedUser.hackathons.append(hackathonTextField!)
            self.hackathonTableView.reloadData()
            User.sharedUser.updateUser()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    /////////FIREBASE DATABASE FUNCTIONS
    ////////////////////////////////////
    private func loadUser()  {
        //load the data from the actual user
        let userDocument = FirebaseService.sharedInstance.database.collection("users").document(User.sharedUser.email.replacingOccurrences(of: "@gmail.com", with: ""))
        
        userDocument.getDocument { (document, error) in
            if let document = document, document.exists {
                let userData = document.data()!
                print(userData)
                
                User.sharedUser.summary = userData["summary"] as! String
                self.ProfileSummaryTextView.text = User.sharedUser.summary
                
                User.sharedUser.name = userData["name"] as! String
                self.ProfileNameLabel.text = User.sharedUser.name
                
                User.sharedUser.id = userData["uid"] as? String ?? ""
                
                let langs = userData["langauges"] as! [String]
                for lang in langs {
                    let language = String(lang.split(separator: ",")[0])
                    let experience = String(lang.split(separator: ",")[1])
                    User.sharedUser.langs += [language + ", " + experience]
                }
                self.languageTableView.reloadData()
                
                let hackathons = userData["hackathons"] as! [String]
                for hack in hackathons {
                    User.sharedUser.hackathons += [hack]
                }
                self.hackathonTableView.reloadData()
                
                self.downloadMedia(fileName: User.sharedUser.email)
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func uploadMedia() {
        let storage = FirebaseService.sharedInstance.storage
        var data = Data()
        let image = self.ProfilePicButton.imageView?.image
        data = image!.pngData()!
        let storageRef = storage!.reference()
        let imageRef = storageRef.child("profilepictures/\(User.sharedUser.email).png")
        _ = imageRef.putData(data, metadata: nil, completion: { (metadata,error ) in
            guard metadata != nil else {
                print(error!)
                return
            }
        })
    }
    
    private func downloadMedia(fileName: String)    {
        let storage = FirebaseService.sharedInstance.storage.reference()
        let profilePicRef = storage.child("profilepictures/\(fileName).png")
        profilePicRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if let error = error {
                print("could not download photo")
                print(error)
                // Uh-oh, an error occurred!
            } else {
                print("downloaded photo")
                self.ProfilePicButton.setImage(UIImage(data: data!), for: .normal)
            }
        }
    }
    //////////////////////////////////
    
    /*
     PROFILE PICKER CODE, FOR CAMERA AND PHOTO LIBRARY
     /////////////////////////////////////////////////
    */
    
    // Creates a UIAlertController to either take a picture or choose from the gallery
    @objc func picTouched(_ sender: UIButton!) {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: "How would you like to set your picture?", preferredStyle: .actionSheet)
        actionSheetController.addAction(UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in })
        actionSheetController.addAction(addPhotoAction(title: "Take Picture", source: .camera, message: "Sorry, the camera is inaccessible"))
        actionSheetController.addAction(addPhotoAction(title: "Choose From Photos", source: .photoLibrary, message: "Sorry, the photo gallery is inaccessible"))
        
        if User.sharedUser.proPic.size != CGSize(width: 0, height: 0) {
            actionSheetController.addAction(UIAlertAction(title: "Delete Current Picture", style: .default) { action -> Void in
                User.sharedUser.proPic = UIImage()
                //self.profileBorder.setImage(UIImage(), for: .normal)
                self.ProfilePicView.isHidden = false
            })
        }
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    // Sets up the screen that allows the user to pick or take a photo
    func addPhotoAction(title: String, source: UIImagePickerController.SourceType, message: String) -> UIAlertAction {
        return UIAlertAction(title: title, style: .default) { action -> Void in
            if UIImagePickerController.isSourceTypeAvailable(source) {
                self.imagePicker.sourceType = source
                self.present(self.imagePicker, animated: true,completion: nil)
            } else {
                self.errorMessage(title: message, message: "")
            }
        }
    }
    
    // Displays the appropriate error message to the user when trying to pick/take a photo
    func errorMessage(title: String, message: String){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    // Updates the profile screen based on the chosen picture
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        let chosenImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as! UIImage
        User.sharedUser.proPic = chosenImage
        //ProfilePicView.image = chosenImage
        ProfilePicButton.setImage(User.sharedUser.proPic, for: .normal)
        ProfilePicButton.imageView?.layer.cornerRadius = ProfilePicButton.layer.cornerRadius
        ProfilePicView.isHidden = true
        
        uploadMedia()
        dismiss(animated:true, completion: nil)
    }
    
    // Dismisses the imagePickerController
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }


    /*
     END CAMERA CODE FOR PROFILE PICTURE FROM CAMERA AND PHOTO LIBARY
     ///////////////////////////////////////////////////////////////
    */
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

