//
//  MessageView.swift
//  social media
//
//  Created by Devang Papinwar on 28/10/21.
//

import SwiftUI

struct MessageView: View
{
    @State var comment : CommentModel
    @State var profileImage : UIImage = UIImage(named: "logo.loading")!
    
    var body: some View
    {
        HStack
        {
            NavigationLink {
                LazyView
                {
                    ProfileView(isMyProfile: false, profileDisplayName: comment.username, posts: PostModelArray(userID: comment.userId) , profileUserId: comment.userId, profileBio: " ")
                }
            } label: {
                Image(uiImage: profileImage)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .frame(width: 40, height: 40, alignment: .center)
            }

            
            
            VStack(alignment: .leading, spacing: 4, content: {
                Text(comment.username)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(comment.content)
                    .padding(.all , 10)
                    .foregroundColor(.primary)
                    .background(Color.gray)
                    .cornerRadius(10)
                
//                Image("bubble")
//                        .resizable(capInsets: EdgeInsets(top: 39, leading: 49, bottom: 39, trailing: 49))
//                        .renderingMode(.template)
//                        .foregroundColor(.blue)
//                     Text("Did you hear about the Swift Wombat website?")
//                        .foregroundColor(.white)
//                        .padding(.horizontal, 16)
//                        .padding(.vertical)
//                        .layoutPriority(1)
                Spacer()
            })
            
            
            
        }
        .onAppear(perform: {
            getProfileImage()
        })
        .padding(.horizontal)
    }
    
    //MARK: FUNCTIONS
    func getProfileImage()
    {
        ImageManager.instance.downloadProfileImage(userID: comment.userId) { returnedImage in
            if let image = returnedImage
            {
                self.profileImage = image
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider
{
    static var comment = CommentModel(commentId: "", userId: "", username: "Joe Breen", content: "Example Comment here", dateCreated: Date())
    static var previews: some View
    {
        MessageView(comment: comment)
    }
}
