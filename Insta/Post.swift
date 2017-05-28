//
//  Post.swift
//  Insta
//
//  Created by Yermakov Anton on 25.05.17.
//  Copyright © 2017 Yermakov Anton. All rights reserved.
//

import UIKit

class Post: NSObject {
    
    var authot: String!
    var likes: Int!
    var pathToImage: String!
    var userId: String!
    var postId: String!
    
    var peopleWhoLike : [String] = [String]()

}
