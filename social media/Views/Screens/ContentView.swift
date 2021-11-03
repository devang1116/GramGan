//
//  ContentView.swift
//  social media
//
//  Created by Devang Papinwar on 28/10/21.
//

import SwiftUI

struct ContentView: View
{
    @AppStorage(CurrentUserDefaults.userID) var currentUserID : String?
    @AppStorage(CurrentUserDefaults.displayName) var currentDisplayName : String?
    @State var userSignedIn : String? = nil
    
    var body: some View
    {
        TabView
        {
            //MARK: Feed View
            NavigationView
            {
                FeedView(posts: PostModelArray(shuffled: false) ,  title: "Feed")
            }
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Feed")
                }
            
            NavigationView
            {
                BrowseView(posts: PostModelArray(shuffled: true))
            }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Browse")
                }
            
            
            UploadScreen()
                .tabItem {
                    Image(systemName: "square.and.arrow.up.fill")
                    Text("Upload")
                }
            
            ZStack
            {
                if let userID = currentUserID , let displayName = currentDisplayName {
                    NavigationView
                    {
                        ProfileView(isMyProfile: true, profileDisplayName: displayName, posts: PostModelArray(userID: userID) , profileUserId: userID, profileBio: " ")
                            
                    }
                }
                else
                {
                    SignUpView()
                }
            }
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Person")
        
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}
