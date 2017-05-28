//
//  UploadViewController.swift
//  Insta
//
//  Created by Yermakov Anton on 24.05.17.
//  Copyright © 2017 Yermakov Anton. All rights reserved.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var previewImage: UIImageView!
    
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var selectBtn: UIButton!
    
    var picker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         picker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            self.previewImage.image = image
            selectBtn.isHidden = true
            postBtn.isHidden = false
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func selectPressed(_ sender: Any) {
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        
        self.present(picker, animated: true, completion: nil)
    }
    

    @IBAction func postPressed(_ sender: Any) {
        AppDelegate.instance().showActivityIndicator()
        
        let uid = FIRAuth.auth()!.currentUser!.uid
        let ref = FIRDatabase.database().reference()
        let storage = FIRStorage.storage().reference()
        
        let key = ref.child("posts").childByAutoId().key
        let imageRef = storage.child("posts").child(uid).child("\(key).jpg")
        
        let data = UIImageJPEGRepresentation(self.previewImage.image!, 1)
        
        let uploadTask = imageRef.put(data!, metadata: nil) { (metadata, error) in
            
            if let error = error{
                print(error.localizedDescription)
            }
            
            imageRef.downloadURL(completion: { (url, err) in
              
                if err != nil{
                    print("error")
                }
                
                let feed = ["userID" : uid, "pathToImage" : url!.absoluteString, "likes" : 0, "author" : FIRAuth.auth()!.currentUser!.displayName!, "postID" : key] as [String : Any]
                
                let postFeed = ["\(key)" : feed]
                
                ref.child("posts").updateChildValues(postFeed)
                AppDelegate.instance().dismissActivityIndicator()
                
                self.dismiss(animated: true, completion: nil)
            })
        }
        uploadTask.resume()
       }
    
    
}




