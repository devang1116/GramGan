//
//  PostView.swift
//  social media
//
//  Created by Devang Papinwar on 28/10/21.
//

import SwiftUI

struct PostView: View
{
    @State var post : PostModel
    @State var animateLike : Bool = false
    @State var addHeartAnimation : Bool
    var showHeadFoot : Bool = true
    
    enum PostActionSheetOption
    {
        case general
        case reporting
    }
    
    @State var postImage: UIImage = UIImage(named: "logo.loading")!
    @State var profileImage : UIImage  = UIImage(named: "logo.loading")!
    
    @State var showActionSheet: Bool = false
    @State var actionSheetType: PostActionSheetOption = .general
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID : String?
    
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
                        LazyView {
                            ProfileView(isMyProfile: false, profileDisplayName: post.username, posts: PostModelArray(userID: post.userId), profileUserId: post.userId, profileBio: " ")
                        }
                        
                    } label: {
                        Image(uiImage: profileImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30, alignment: .center)
                        .cornerRadius(15)
                        
                        Text(post.username)
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
                Image(uiImage: postImage)
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
                        if post.likedByUser
                        {
                            unlikePost()
                        }
                        else
                        {
                            likePost()
                        }
                    } label: {
                        Image(systemName: post.likedByUser ? "heart.fill" : "heart")
                            .font(.title3)
                    }
                    .accentColor(post.likedByUser ? Color.red : Color.primary)

                    
    
                    NavigationLink(destination: CommentsView(post: post) ,
                                   label: {
                                        Image(systemName: "bubble.middle.bottom")
                                                    .font(.title3)
                                                    .foregroundColor(.primary)
                    })
                    
                    Image(systemName: "paperplane")
                        .font(.title3)
                        .onTapGesture
                        {
                            sharePost()
                        }
                    Spacer()
                })
                    .padding(.all , 10)
                HStack {
                    Text(post.caption ?? " ")
                        .font(.caption)
                    Spacer(minLength: 0)
                }
                .padding(.all , 6)
            }
        })
            .onAppear
            {
                getImages()
            }
    }
    
    //MARK: Functions
    func likePost()
    {
        // Check if user is Signed in
        guard let userID = currentUserID else
        {
            print("Cannot find UserID while liking the post")
            return
        }
        
        // Update the Local Data
        let post = PostModel(postId: post.postId, userId: post.userId, username: post.username, caption: post.caption, likeCount: post.likeCount + 1, dateCreate: post.dateCreate, likedByUser: true)
        self.post = post

        // Animate UI
        animateLike = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            animateLike = false
        }
        
        // Update the Database
        DataService.instance.likePost(postID: post.postId, currentUserID: userID)
    }

    func unlikePost()
    {
        // Check if user is Signed in
        guard let userID = currentUserID else
        {
            print("Cannot find UserID while unLiking the post")
            return
        }
        
        // Update the Local Data
        let post = PostModel(postId: post.postId, userId: post.userId, username: post.username, caption: post.caption, likeCount: post.likeCount - 1, dateCreate: post.dateCreate, likedByUser: false)

        self.post = post
        
        // Update the Database
        DataService.instance.unLikePost(postID: post.postId, currentUserID: userID)
    }
    
    func getImages()
    {
        ImageManager.instance.downloadProfileImage(userID: post.userId) { returnedImage in
            if let image = returnedImage
            {
                self.profileImage = image
            }
            
            ImageManager.instance.downloadPostImage(postID: post.postId) { returnedImage in
                if let image = returnedImage
                {
                    self.postImage = image
                }
            }
        }
    }
    
    func getActionSheet() -> ActionSheet {
        
        switch self.actionSheetType
        {
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
    
    func reportPost(reason: String)
    {
        print("REPORT POST NOW")
    }

    func sharePost()
    {
        
        let message = "Check out this post on GangGram"
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
        PostView(post: post , addHeartAnimation : true, showHeadFoot: true)
    }
}
