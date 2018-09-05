//
//  PostController.swift
//  Subreddit
//
//  Created by Eric Andersen on 9/4/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import UIKit

class PostController {
    
    static let shared = PostController()
    static let baseURL = URL(string: "https://www.reddit.com/r/")
    var posts: [Post] = []
    
    
    func fetchPosts(by searchTerm: String, completion: @escaping() -> Void) {
        
        guard let baseURL = PostController.baseURL else { return }
        let url = baseURL.appendingPathComponent(searchTerm).appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            do {
                
                if let error = error {
                    print("There was an error in \(#function) Error: \(error)")
                    completion()
                    return
                }
                
                guard let data = data else { completion(); return }
                
                let decoder = JSONDecoder()
                let jsonDictionary = try decoder.decode(JSONDictionary.self, from: data)
                let postsWithoutImages = jsonDictionary.data.children.compactMap({ $0.post })
                self.posts = postsWithoutImages
                completion()
                
            } catch let error {
                print("There was an error decoding the json data. Error: \(error.localizedDescription)")
                completion()
                return
            }
        }.resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping(UIImage?) -> Void) {
        
        guard let url = URL(string: urlString) else { completion(nil); return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print("There was an error fetching the post's thumbnail: Error \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else { completion(nil); return }
            completion(image)
        }.resume()
    }
}
