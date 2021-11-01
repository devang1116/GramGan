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
    @State var userSignedIn : String? = nil
    
    var body: some View
    {
        TabView
        {
            //MARK: Feed View
            NavigationView
            {
                FeedView(posts: PostModelArray() ,  title: "Feed")
            }
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Feed")
                }
            
            NavigationView
            {
                BrowseView()
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
                if let userID = currentUserID {
                    NavigationView
                    {
                        ProfileView(isMyProfile: true, profileDisplayName: "My Profile" , profileUserId: "")
                            
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
