//
//  PostView.swift
//  social media
//
//  Created by Devang Papinwar on 28/10/21.
//

import SwiftUI

struct PostView: View
{
    @State var postModel : PostModel
    @State var animateLike : Bool = false
    @State var addHeartAnimation : Bool
    var showHeadFoot : Bool = true
    @State var postImage: UIImage = UIImage(named: "dog1")!
    
    enum PostActionSheetOption {
        case general
        case reporting
    }
    
    @State var showActionSheet: Bool = false
    @State var actionSheetType: PostActionSheetOption = .general
    
    var body: some View
    {
        VStack(alignment: .center, spacing: 0, content:
        {
            //MARK: Header
            if showHeadFoot
            {
                HStack
                {
                    NavigationLink
                    {
                        ProfileView(isMyProfile: false, profileDisplayName: postModel.username, profileUserId: postModel.userId)
                    } label: {
                        Image("dog1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30, alignment: .center)
                        .cornerRadius(15)
                        
                        Text(postModel.username)
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                    }

                    Spacer()
                    
                    Button {
                        showActionSheet.toggle()
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.headline)
                            .actionSheet(isPresented: $showActionSheet, content: {
                                getActionSheet()
                            })
                    }
                }
                .padding()
            }
            
            
            //MARK: Image
            ZStack
            {
                Image("dog1")
                    .resizable()
                .scaledToFit()
                
                if addHeartAnimation
                {
                    LikeAnimationView(animate: $animateLike)
                }
            }

            //MARK: Footer
            if showHeadFoot
            {
                HStack(alignment: .center, spacing: 20, content: {
                    
                    Button {
                        if postModel.likedByUser
                        {
                            unlikePost()
                        }
                        else
                        {
                            likePost()
                        }
                    } label: {
                        Image(systemName: postModel.likedByUser ? "heart.fill" : "heart")
                            .font(.title3)
                    }
                    .accentColor(postModel.likedByUser ? Color.red : Color.primary)

                    
                    
                    NavigationLink(destination: CommentsView() ,
                                   label: {
                                        Image(systemName: "bubble.middle.bottom")
                                                    .font(.title3)
                                                    .foregroundColor(.primary)
                    })
                    
                    Image(systemName: "paperplane")
                        .font(.title3)
                    Spacer()
                })
                    .padding(.all , 10)
                HStack {
                    Text(postModel.caption ?? " ")
                        .font(.caption)
                    Spacer(minLength: 0)
                }
                .padding(.all , 6)
            }
        })
    }
    
    //MARK: Functions
    func likePost()
    {
        let post = PostModel(postId: postModel.postId, userId: postModel.userId, username: postModel.username, caption: postModel.caption, likeCount: postModel.likeCount + 1, dateCreate: postModel.dateCreate, likedByUser: true)
        self.postModel = post

        animateLike = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            animateLike = false
        }
    }

    func unlikePost()
    {
        let post = PostModel(postId: postModel.postId, userId: postModel.userId, username: postModel.username, caption: postModel.caption, likeCount: postModel.likeCount - 1, dateCreate: postModel.dateCreate, likedByUser: false)

        self.postModel = post
    }
    
    func getActionSheet() -> ActionSheet {
        
        switch self.actionSheetType {
        case .general:
            return ActionSheet(title: Text("What would you like to do?"), message: nil, buttons: [
                .destructive(Text("Report"), action: {
                    
                    self.actionSheetType = .reporting
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.showActionSheet.toggle()
                    }
                    
                }),
                
                .default(Text("Learn more..."), action: {
                    print("LEARN MORE PRESSED")
                }),
                
                .cancel()
            ])
        case .reporting:
            return ActionSheet(title: Text("Why are you reporting this post?"), message: nil, buttons: [
                
                .destructive(Text("This is inappropriate"), action: {
                    reportPost(reason: "This is inappropriate")
                }),
                .destructive(Text("This is spam"), action: {
                    reportPost(reason: "This is spam")
                }),
                .destructive(Text("It made me uncomfortable"), action: {
                    reportPost(reason: "It made me uncomfortable")
                }),

                .cancel({
                    self.actionSheetType = .general
                })
            ])
        }
        
        
    }
    
    func reportPost(reason: String) {
        print("REPORT POST NOW")
    }

    func sharePost() {
        
        let message = "Check out this post on DogGram!"
        let image = postImage
        let link = URL(string: "https://www.google.com")!
        
        let activityViewController = UIActivityViewController(activityItems: [message, image, link], applicationActivities: nil)
        
        let viewController = UIApplication.shared.windows.first?.rootViewController
        viewController?.present(activityViewController, animated: true, completion: nil)
        
    }
}

struct PostView_Previews: PreviewProvider
{
    static var post : PostModel = PostModel(postId: "", userId: "", username: "Joe Green", caption: "This is test cption", likeCount: 0, dateCreate: Date(), likedByUser: false)
    static var previews: some View
    {
        PostView(postModel: post , addHeartAnimation : true, showHeadFoot: true)
    }
}
