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
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddPhotoViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddPhotoViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        view.isUserInteractionEnabled = false
        guard let title = titleField.text, !title.isEmpty else {
            showError(title: "Error", error: "Title is empty")
            view.isUserInteractionEnabled = true

            return
        }
        
        guard let caption = caption.text, !caption.isEmpty else {
            showError(title: "Error", error: "Enter your recipe please!")
            view.isUserInteractionEnabled = true

            return
        }
        
        guard let image = uploadImage.image else {
            showError(title: "Error", error: "Bad image")
            view.isUserInteractionEnabled = true

            return
        }
        
        
        FoodClient.sharedInstance.createRecipe(picture: image, title: title, recipe: caption, success: { (recipe) in
            self.view.isUserInteractionEnabled = true

            self.navigationController?.popViewController(animated: true)
        }) { (error) in
            print (error.localizedDescription)
            self.view.isUserInteractionEnabled = true

        }
        
        
        
    }
    
    func showError(title: String, error: String) {
        let alert = UIAlertController(title: title, message: error, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print ("ok tappped")
        }
        alert.addAction(OKAction)
        self.present(alert, animated: true)
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
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onTap(_ sender: Any) {
        
        view.endEditing(true)
    }
    
    
    
}
