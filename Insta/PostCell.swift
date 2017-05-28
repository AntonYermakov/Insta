//
//  PostCell.swift
//  Insta
//
//  Created by Yermakov Anton on 25.05.17.
//  Copyright © 2017 Yermakov Anton. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UICollectionViewCell {
 
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var unlikeBtn: UIButton!
    
    var postID: String!
    
    
    @IBAction func likePressed(_ sender: Any) {
        let ref = FIRDatabase.database().reference()
        let keyToPost = ref.child("posts").childByAutoId().key
        
        ref.child("posts").child(self.postID)
    }
    
    @IBAction func unlikePressed(_ sender: Any) {
        
    }
    
    
}
