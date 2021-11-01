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
                        MessageView(commentModel: comment)
                    }
                }
            }
            
            
            //MARK: Add Comment
            HStack
            {
                Image("dog1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height:40, alignment: .center)
                    .cornerRadius(20)
                
                TextField("Add a comment here", text: $submissionText)
                
                Button ( action : {
                    
                } , label : {
                    Image("paperplane.fill")
                        .font(.title2)
                })
                    .accentColor(Color.purple)
                
                
            }
            .padding()
        }
        .navigationBarTitle("Comments")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            getComments()
        })
    }
    
    //MARK: Functions
    func getComments()
    {
        print("Gets Comments from Database")
        
        var comment1 = CommentModel(commentId: "", userId: "", username: "Joe Breen", content: "Hey its sick", dateCreated: Date())
        var comment2 = CommentModel(commentId: "", userId: "", username: "Emily Watson", content: "yo shut the fuck up", dateCreated: Date())
        var comment3 = CommentModel(commentId: "", userId: "", username: "Jaylen Brwon", content: "ill dunk on yo bitch ass", dateCreated: Date())
        var comment4 = CommentModel(commentId: "", userId: "", username: "Lebron James", content: "Yo its the king", dateCreated: Date())
        
        self.comments.append(comment1)
        self.comments.append(comment2)
        self.comments.append(comment3)
        self.comments.append(comment4)
    }
}

struct CommentsView_Previews: PreviewProvider
{
    static var previews: some View
    {
        NavigationView
        {
            CommentsView()
        }
    }
}
