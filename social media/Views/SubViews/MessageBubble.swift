////
////  MessageBubble.swift
////  social media
////
////  Created by Devang Papinwar on 03/11/21.
////
//
//import SwiftUI
//
//struct MessageBubble : View
//{
//    let position: BubblePosition = .left
//    let color : Color = Color.orange
//    
//    @State var comment : CommentModel
//    @State var profileImage : UIImage = UIImage(named: "logo.loading")!
//
//    var body: some View
//    {
//        HStack(spacing: 0 )
//        {
//                .padding(.all, 15)
//                .foregroundColor(Color.white)
//                .background(color)
//                .clipShape(RoundedRectangle(cornerRadius: 18))
//                .overlay(
//                    Image(systemName: "arrowtriangle.left.fill")
//                        .foregroundColor(color)
//                        .rotationEffect(Angle(degrees: position == .left ? -50 : -130))
//                        .offset(x: position == .left ? -5 : 5)
//        }
//        .padding(position == .left ? .leading : .trailing , 15)
//        .padding(position == .right ? .leading : .trailing , 60)
//        .frame(width: UIScreen.main.bounds.width, alignment: position == .left ? .leading : .trailing)
//
//        HStack
//        {
//            NavigationLink {
//                LazyView
//                {
//                    ProfileView(isMyProfile: false, profileDisplayName: comment.username, posts: PostModelArray(userID: comment.userId) , profileUserId: comment.userId, profileBio: " ")
//                }
//            } label: {
//                Image(uiImage: profileImage)
//                    .resizable()
//                    .scaledToFit()
//                    .cornerRadius(20)
//                    .frame(width: 40, height: 40, alignment: .center)
//            }
//
//
//
//            VStack(alignment: .leading, spacing: 4, content: {
//                Text(comment.username)
//                    .font(.caption)
//                    .foregroundColor(.gray)
//
//                Text(comment.content)
//                    .padding(.all , 10)
//                    .foregroundColor(.primary)
//                    .background(Color.gray)
//                    .cornerRadius(10)
//                Spacer()
//            })
//
//
//
//        }
//        .onAppear(perform: {
////            getProfileImage()
//        })
//        .padding(.horizontal)
//    }
//}
//
//struct MessageBubble_Previews: PreviewProvider
//{
//    static var previews: some View
//    {
//        MessageBubble(comment: CommentModel(commentId: " ", userId: " ", username: " ", content: " ", dateCreated: Date()))
//    }
//}
//
//
//
