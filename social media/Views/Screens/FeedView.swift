//
//  FeedView.swift
//  social media
//
//  Created by Devang Papinwar on 28/10/21.
//

import SwiftUI

struct FeedView: View
{
    @ObservedObject var posts = PostModelArray()
    var title : String
    
    var body: some View
    {
        ScrollView(.vertical)
        {
            //MARK: Posts Views
            LazyVStack
            {
                ForEach(posts.dataArray ,  id:\.self) { post in
                    PostView(post: post , addHeartAnimation: true,  showHeadFoot: true)
                }
            }
        }
        .navigationBarTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FeedView_Previews: PreviewProvider
{
    static var previews: some View
    {
        NavigationView
        {
            FeedView(posts: PostModelArray() , title: "FeedView")
        }
    }
}
