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
    var body: some View
    {
        VStack(alignment: .center, spacing: 10, content: {
            //MARK: Profile Picture
            Image("dog1")
                .resizable()
                .scaledToFit()
                .cornerRadius(60)
                .frame(width: 60, height: 60, alignment: .center)
            
            //MARK: Profile User Name
            Text(profileDisplayName)
                .font(.title)
                .fontWeight(.bold)
            
            //MARK: Profile Bio
            Text("This is the area where the user can add their bio")
                .font(.body)
                .fontWeight(.regular)
            
            //MARK: Profile Likes
            HStack(alignment: .center, spacing: 20, content: {
                VStack(alignment: .center, spacing: 5) {
                    Text("5")
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
    @State static var name = "Devang"
    static var previews: some View
    {
        ProfileHeaderView(profileDisplayName: $name)
    }
}
