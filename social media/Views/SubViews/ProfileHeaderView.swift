//
//  ProfileHeaderView.swift
//  social media
//
//  Created by Devang Papinwar on 30/10/21.
//

import SwiftUI

struct ProfileHeaderView: View
{
    @Binding var profileDisplayName : String
    @Binding var profileImage: UIImage
    @ObservedObject var postArray : PostModelArray
    @Binding var profileBio : String
    
    var body: some View
    {
        VStack(alignment: .center, spacing: 10, content: {
            //MARK: Profile Picture
            Image(uiImage: profileImage)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 200, alignment: .center)
                //.cornerRadius(60)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
            
            //MARK: Profile User Name
            Text(profileDisplayName)
                .font(.title)
                .fontWeight(.bold)
            
            //MARK: Profile Bio
            Text(profileBio)
                .font(.body)
                .fontWeight(.regular)
            
            //MARK: Profile Likes
            HStack(alignment: .center, spacing: 20, content: {
                VStack(alignment: .center, spacing: 5) {
                    Text(postArray.likeCount)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Capsule()
                        .frame(width: 20, height: 2, alignment: .center)
                    
                    Text("Likes")
                        .font(.callout)
                        .fontWeight(.medium)
                }
                
                VStack(alignment: .center, spacing: 5) {
                    Text(postArray.posts)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Capsule()
                        .frame(width: 20, height: 2, alignment: .center)
                    
                    Text("Posts")
                        .font(.callout)
                        .fontWeight(.medium)
                }
            })
        })
            .frame(maxWidth : .infinity)
            .padding()
    }
}

struct ProfileHeaderView_Previews: PreviewProvider
{
    @State static var name : String = "Devang"
    @State static var image: UIImage = UIImage(named: "dog1")!
    static var previews: some View
    {
        ProfileHeaderView(profileDisplayName: $name, profileImage: $image, postArray: PostModelArray(shuffled: false), profileBio: $name)
    }
}
