//
//  FirstViewController.swift
//  HackMeet
//
//  Created by Matthew Swenson on 3/28/19.
//  Copyright © 2019 Matthew Swenson. All rights reserved.
//

struct Lang: Codable {
    var language: String!
    var experience: String!
}

struct UserModel: Codable    {
    var name: String
    var uid: Int
    var checksum: Int
    var email: String
    var summary: String
    var profilepicture: URL
    var langauges: [Lang]
    var hackathons: String
}

import UIKit
import SwiftyJSON

class FirstViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var ProfilePicButton: UIButton!
    @IBOutlet var ProfilePicView: UIImageView!
    @IBOutlet var ProfileNameLabel: UILabel!
    @IBOutlet var ProfileSummaryTextView: UITextView!
    @IBOutlet var ProfileScreenScrollView: UIScrollView!
    @IBOutlet var languageTableView: UITableView!
    
    let imagePicker =  UIImagePickerController()
    
    var user = User.sharedUser
    let defaults = UserDefaults.standard
    
    var langs = [Lang]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        ProfileSummaryTextView.delegate = self
        languageTableView.delegate = self
        languageTableView.dataSource = self
        
        ProfilePicButton.layer.borderColor = (UIColor.init(red: 255/255, green: 150/255, blue: 150/255, alpha: 1)).cgColor
        ProfilePicButton.layer.borderWidth = 5
        ProfilePicButton.layer.cornerRadius = 10
        ProfilePicButton.addTarget(self, action: #selector(self.picTouched(_:)), for: .touchUpInside)
        user.proPic = defaults.object(forKey: "UserProfilePicture") as? UIImage ?? UIImage(named: "defaultPic")!
        //loadViews()
        loadSampleViews()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)    {
        print("editing")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        user.summary = textView.text!
        print(user.summary)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return langs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileLangTableViewCell", for: indexPath) as? ProfileLangTableViewCell else {
            fatalError("the dequed cell is not an instance of UserTableViewCell")
        }
        
        let lang = langs[indexPath.row]
        
        cell.languageLabel.text = lang.language
        defaults.set(lang.language, forKey: "userLanguage + \(indexPath)")
        cell.experienceLabel.text = lang.experience
        defaults.set(lang.language, forKey: "userExperience + \(indexPath)")
        
        return cell
    }
    
    func loadViews()    {
        //load the JSON from the actual users
        
        guard let url = URL(string: "http://google.com") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do {
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let model = try decoder.decode([UserModel].self, from:
                    dataResponse) //Decode JSON Response Data
                print(model)
                
                //do something with JSON
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    private func loadSampleViews()  {
        let lang1 = Lang(language: "Racket", experience: "5 Years")
        let lang2 = Lang(language: "Java", experience: "2 Years")

        langs += [lang1, lang2]
    }
    
    
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
        
        if user.proPic.size != CGSize(width: 0, height: 0) {
            actionSheetController.addAction(UIAlertAction(title: "Delete Current Picture", style: .default) { action -> Void in
                self.user.proPic = UIImage()
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
        user.proPic = chosenImage
        ProfilePicView.image = chosenImage
        ProfilePicButton.setImage(user.proPic, for: .normal)
        ProfilePicButton.imageView?.layer.cornerRadius = ProfilePicButton.layer.cornerRadius
        ProfilePicView.isHidden = true
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

