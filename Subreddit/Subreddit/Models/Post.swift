//
//  Post.swift
//  Subreddit
//
//  Created by Eric Andersen on 9/4/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import Foundation

struct JSONDictionary: Decodable {
    let data: DataDictionary
    
    struct DataDictionary: Decodable {
        let children: [PostDictionary]
        
        struct PostDictionary: Decodable {
            let post: Post
            
            enum CodingKeys: String, CodingKey {
                case post = "data"
            }
        }
    }
}


struct Post: Decodable {
    
    let title: String
    let thumbnailEndpoint: String
    let numberOfUpvotes: Int
    let numberOfDownvotes: Int
    let numberOfComments: Int
    
    enum CodingKeys: String, CodingKey {
        
        case title
        case thumbnailEndpoint = "thumbnail"
        case numberOfUpvotes = "ups"
        case numberOfDownvotes = "downs"
        case numberOfComments = "num_comments"
    }
}
