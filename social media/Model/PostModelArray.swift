//
//  PostModelArray.swift
//  social media
//
//  Created by Devang Papinwar on 28/10/21.
//

import Foundation
import SwiftUI

class PostModelArray : ObservableObject
{
    @Published var dataArray = [PostModel]()
    @Published var likeCount = "0"
    @Published var posts = "5"
    
    init()
    {
        let post1 = PostModel(postId: "", userId: "", username: "Joe Breen", caption: "Test Caption1", likeCount: 0, dateCreate: Date(), likedByUser: false)
        let post2 = PostModel(postId: "", userId: "", username: "Emily Watson", caption: "Test Caption2", likeCount: 0, dateCreate: Date(), likedByUser: false)
        let post3 = PostModel(postId: "", userId: "", username: "Danny Granger", caption: "Test Caption3", likeCount: 0, dateCreate: Date(), likedByUser: false)
        let post4 = PostModel(postId: "", userId: "", username: "Jayson Tatum", caption: "Test Caption4", likeCount: 0, dateCreate: Date(), likedByUser: false)
        
        self.dataArray.append(post1)
        self.dataArray.append(post2)
        self.dataArray.append(post3)
        self.dataArray.append(post4)
    }
    
    /// Used for getting single post
    init(post : PostModel)
    {
        self.dataArray.append(post)
    }
    
    /// Used for getting Posts for User profile
    init(userID : String)
    {
        print("Get Posts for UserID")
        DataService.instance.downloadPostForUser(userID: userID) { posts in
            let sortedPosts = posts.sorted { (post1 , post2) -> Bool in
                return post1.dateCreate >  post2.dateCreate
            }
            self.dataArray.append(contentsOf: sortedPosts)
            self.updateCount()
        }
    }
    
    ///Used for feed
    init(shuffled : Bool)
    {
        DataService.instance.downloadPostForFeed { returnedPosts in
            if shuffled
            {
                let shuffledPosts = returnedPosts.shuffled()
                self.dataArray.append(contentsOf: shuffledPosts)
            }
            else
            {
                self.dataArray.append(contentsOf: returnedPosts)
            }
        }
        self.updateCount()
    }
    
    func updateCount()
    {
        self.posts = "\(self.dataArray.count)"
        
        let likeCountArray = dataArray.map { exisitingPost in
            return exisitingPost.likeCount
        }
        
        let likeSum = likeCountArray.reduce(0, +)
        self.likeCount = "\(likeSum)"
    }
}
