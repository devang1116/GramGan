//
//  ProfileView.swift
//  social media
//
//  Created by Devang Papinwar on 30/10/21.
//

import SwiftUI

struct ProfileView: View
{
    var isMyProfile : Bool
    var posts = PostModelArray()
    @State var profileDisplayName : String
    @State var showSettings = false
    var profileUserId : String
    
    var body: some View
    {
        ScrollView(.vertical, showsIndicators: false , content: {
            ProfileHeaderView(profileDisplayName: $profileDisplayName)
            Divider()
            ImageGridView(posts: posts)
        })
            .navigationBarTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                showSettings.toggle()
            }, label: {
                Image(systemName: "line.horizontal.3")
                    .opacity(isMyProfile ? 1.0 : 0.0)
            }))
            .sheet(isPresented:  $showSettings) {
                SettingsView()
            }
            
    }
}

struct ProfileView_Previews: PreviewProvider
{
    static var previews: some View
    {
        NavigationView
        {
            ProfileView(isMyProfile : true , profileDisplayName: "Joe", profileUserId: "")
        }
    }
}
