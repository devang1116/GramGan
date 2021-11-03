//
//  ImageGridView.swift
//  social media
//
//  Created by Devang Papinwar on 29/10/21.
//

import SwiftUI

struct ImageGridView: View
{
    @ObservedObject var posts = PostModelArray()
    var body: some View
    {
        LazyVGrid(columns: [GridItem(.flexible()) ,
                            GridItem(.flexible()),
                            GridItem(.flexible())],
                  alignment: .center,
                  spacing: nil,
                  pinnedViews: [],
                  content: {
            ForEach(posts.dataArray, id:\.self ) { post in
                NavigationLink(destination: FeedView(posts: PostModelArray(post: post ) , title: "Post"))
                {
                    PostView(post: post , addHeartAnimation: false,  showHeadFoot: false )
                }
            }
        })
    }
}

struct ImageGridView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ImageGridView()
    }
}
