//
//  MessageView.swift
//  social media
//
//  Created by Devang Papinwar on 28/10/21.
//

import SwiftUI

struct MessageView: View
{
    @State var commentModel : CommentModel
    
    var body: some View
    {
        HStack
        {
            Image("dog1")
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .frame(width: 40, height: 40, alignment: .center)
            
            VStack(alignment: .leading, spacing: 4, content: {
                Text(commentModel.username)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(commentModel.content)
                    .padding(.all , 10)
                    .foregroundColor(.primary)
                    .background(Color.gray)
                    .cornerRadius(10)
            })
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct MessageView_Previews: PreviewProvider
{
    static var comment = CommentModel(commentId: "", userId: "", username: "Joe Breen", content: "Example Comment here", dateCreated: Date())
    static var previews: some View
    {
        MessageView(commentModel: comment)
    }
}
