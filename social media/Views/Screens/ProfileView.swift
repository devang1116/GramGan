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
    @State var profileDisplayName : String

    var posts : PostModelArray

    @State var showSettings = false
    var profileUserId : String
    @State var profileBio : String
    
    @State var profileImage: UIImage = UIImage(named: "logo.loading")!
    
    var body: some View
    {
        ScrollView(.vertical, showsIndicators: false , content: {
            ProfileHeaderView(profileDisplayName: $profileDisplayName, profileImage: $profileImage, postArray: posts, profileBio: $profileBio)
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
            .onAppear(perform: {
                getProfileImage()
            })
            .sheet(isPresented:  $showSettings) {
                SettingsView(userBio: $profileBio, userName: $profileDisplayName, userProfilePicture: $profileImage)
            }
    }
    
    //MARK: FUNCTIONS
    func getProfileImage()
    {
        print("Getting profile Image Data")
        ImageManager.instance.downloadProfileImage(userID: profileUserId) { returnedImage in
            if let image = returnedImage
            {
                self.profileImage = image
                print("Image Set Success")
            }
        }
    }
    
    func getAdditionalProfileInfo()
    {
        print("Getting additional User Profile Data")
        AuthService.instance.getUserData(forUserID: profileUserId) { returnedName, returnedBio in
            if let name = returnedName
            {
                self.profileDisplayName = name
            }
            if let bio = returnedBio
            {
                self.profileBio = bio
            }
        }
    }
}
 
struct ProfileView_Previews: PreviewProvider
{
    static var previews: some View
    {
        NavigationView
        {
            ProfileView(isMyProfile : true , profileDisplayName: "Joe", posts: PostModelArray(userID: " "), profileUserId: "", profileBio: " " )
        }
    }
}
