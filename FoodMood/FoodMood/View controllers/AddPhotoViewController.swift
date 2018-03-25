//
//  AddPhotoViewController.swift
//  FoodMood
//
//  Created by Dhriti Chawla on 3/25/18.
//  Copyright © 2018 iOSGroupProject. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var titleField: UITextField!
    
    
    
    var databaseRef = Database.database().reference()
    var storageRef = Storage.storage().reference()
    var picture: String = ""
    
    var imagePicker = UIImagePickerController()
    var loggedInUser: AnyObject?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        
        if (!AllVariables.photos.contains(titleField.text!)) {
            let c = "Photo\(AllVariables.photos.endIndex)"
            print(AllVariables.photos.endIndex)
            
            if (titleField.text != "") {
                if (caption.text != "") {
                
                            AllVariables.photos.append(titleField.text!)
                    
                            databaseRef.child("RecipePictures").child(c).setValue(["Username": AllVariables.Username, "Title": titleField.text!, "Recipe": caption.text! ,"Photo": picture ])
                    
                }
                else {
                    let alert = UIAlertController(title: "Error", message: "Please provide a short recipe!", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        print ("ok tappped")
                    }
                    alert.addAction(OKAction)
                    self.present(alert, animated: true) {
                        print("ERROR")
                    }
                }
            }
            else {
                let alert = UIAlertController(title: "Error", message: "Please provide your dish name!", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    print ("ok tappped")
                }
                alert.addAction(OKAction)
                self.present(alert, animated: true) {
                    print("ERROR")
                }
            }
        }
        else {
            
            let alert = UIAlertController(title: "Error", message: "You have already posted this recipe!", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                print ("ok tappped")
            }
            alert.addAction(OKAction)
            self.present(alert, animated: true) {
                print("ERROR")
            }
        }
        
        
        
        
    }
    
    @IBAction func profpicButton(_ sender: Any) {
        let myActionSheet = UIAlertController(title: "Recipe Picture", message: "Select", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let viewPicture = UIAlertAction(title: "View Picture", style: UIAlertActionStyle.default) { (action) in
            let imageView = sender as! UIImageView
            let newImageView = UIImageView(image: imageView.image)
            
            newImageView.frame = self.view.frame
            newImageView.backgroundColor = UIColor.black
            newImageView.contentMode = .scaleAspectFit
            newImageView.isUserInteractionEnabled = true
            
            self.view.addSubview(newImageView)
        }
        let photoGallery = UIAlertAction(title: "Photos", style: UIAlertActionStyle.default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum)
            {
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        
        let camera = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        myActionSheet.addAction(viewPicture)
        myActionSheet.addAction(photoGallery)
        myActionSheet.addAction(camera)
        myActionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(myActionSheet, animated: true, completion: nil)
    }
    
    func setProfilePicture(imageView:UIImageView, imageToSet:UIImage)
    {
        imageView.layer.cornerRadius = 10.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = true
        imageView.image = imageToSet
        print (".....")
        print (imageView.image)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        setProfilePicture(imageView: self.uploadImage, imageToSet: image)
        
        if let imageData: NSData = UIImagePNGRepresentation(self.uploadImage.image!)! as NSData
        {
            let profilePicStorageRef = storageRef.child("Users/recipe_pic")

            let uploadTask = profilePicStorageRef.putData(imageData as Data, metadata: nil)
            {metadata, error in
                if (error == nil) {
                    let downloadURL = metadata?.downloadURL()
                    
                    self.picture = downloadURL!.absoluteString
                    print("successful upload")
                }
                else {
                    print(error?.localizedDescription)
                }
                //self.imageLoader.stopAnimating()
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
