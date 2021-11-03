//
//  BrowseView.swift
//  social media
//
//  Created by Devang Papinwar on 29/10/21.
//

import SwiftUI

struct BrowseView: View
{
    var posts : PostModelArray
    var body: some View
    {
        ScrollView(.vertical, showsIndicators: false, content: {
            GroupBox {
                
            } label: {
                CarouselView()
                ImageGridView(posts: posts)
            }
        })
            .navigationBarTitle("Browse")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        
    }
}

struct BrowseView_Previews: PreviewProvider
{
    static var previews: some View
    {
        NavigationView
        {
            BrowseView(posts: PostModelArray(shuffled: true))
        }
    }
}
