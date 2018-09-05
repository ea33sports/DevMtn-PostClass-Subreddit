//
//  PostTableViewCell.swift
//  Subreddit
//
//  Created by Eric Andersen on 9/4/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    var thumbnail: UIImage? {
        didSet {
            updateViews()
        }
    }
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var upvotesLabel: UILabel!
    @IBOutlet weak var downVotesLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var commentsCountLabel: UILabel!
    
    
    
    func updateViews() {
        
        guard let post = post else { return }
        titleLabel.text = post.title
        upvotesLabel.text = "# of upvotes: \(post.numberOfUpvotes)"
        downVotesLabel.text = "# of downvotes: \(post.numberOfDownvotes)"
        commentsCountLabel.text = "# of comments: \(post.numberOfComments)"
        thumbnailImageView.image = UIImage(named: post.thumbnailEndpoint) ?? #imageLiteral(resourceName: "no-image-available")
    }
}
