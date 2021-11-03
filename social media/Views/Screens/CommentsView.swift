//
//  CommentsView.swift
//  social media
//
//  Created by Devang Papinwar on 28/10/21.
//

import SwiftUI

struct CommentsView: View
{
    @State var submissionText : String = " "
    @State var comments = [CommentModel]()
    var post : PostModel
    
    @State var profileImage : UIImage = UIImage(named: "logo.loading")!
    @AppStorage(CurrentUserDefaults.userID) var currentUserID : String?
    @AppStorage(CurrentUserDefaults.displayName) var currentDisplayName : String?
    
    var body: some View
    {
        VStack
        {
            ScrollView
            {
                //MARK: Comments View
                LazyVStack
                {
                    ForEach(comments, id:\.self) { comment in
                        MessageView(comment: comment)
                    }
                }
            }
            
            
            //MARK: Add Comment
            HStack
            {
                Image(uiImage: profileImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height:40, alignment: .center)
                    .cornerRadius(20)
                
                TextField("Add a comment here", text: $submissionText)
                
                Button(action: {
                    if textIsAppropriate() {
                        addComment()
                    }
                }, label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                })
                    .accentColor(Color.red)
                
                
            }
            .padding()
        }
        .navigationBarTitle("Comments")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            getComments()
            getProfilePicture()
        })
    }
    
    //MARK: Functions
    func getProfilePicture()
    {
        // check if user if logged in
        guard let userID = currentUserID else
        {
            return
        }
        
        // download the profile picture
        ImageManager.instance.downloadProfileImage(userID: userID) { returnedImage in
            if let image = returnedImage
            {
                self.profileImage = image
            }
        }
    }
    
    func getComments()
    {
        guard self.comments.isEmpty else { return }
        
        print("Gets Comments from Database")
        
        DataService.instance.downloadComments(postID: post.postId) { (returnedComments) in
            self.comments.append(contentsOf: returnedComments)
        }
    }
    
    func textIsAppropriate() -> Bool
    {
        // Check if the comment is InAppropriate
        let badWordArray : [String] = ["shit" , "ass"]
        
        let words = submissionText.components(separatedBy: " ")
        for word in words
        {
            if badWordArray.contains(word)
            {
                return false
            }
        }
        
        if submissionText.count < 3
        {
            return false
        }
        return true
     }
    
    func addComment()
    {
        guard let userID = currentUserID ,let  displayName = currentDisplayName else { return }
        DataService.instance.uploadComments(postID: post.postId, content: submissionText, displayName: displayName, userID: userID) { success, returnedCommentID in
            if success , let commentID = returnedCommentID
            {
                let comment = CommentModel(commentId: commentID, userId: userID, username: displayName, content: submissionText, dateCreated: Date())
                self.comments.append(comment)
                self.submissionText = ""
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}

struct CommentsView_Previews: PreviewProvider
{
    static var post = PostModel( postId: "", userId: "", username: "", caption: "", likeCount: 0, dateCreate: Date(), likedByUser: false)
    static var previews: some View
    {
        NavigationView
        {
            CommentsView(post: post)
        }
    }
}
