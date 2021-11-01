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
    
    //// Single Post
    init(post : PostModel)
    {
        self.dataArray.append(post)
    }
}
