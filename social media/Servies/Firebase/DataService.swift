//
//  DataService.swift
//  social media
//
//  Created by Devang Papinwar on 02/11/21.
//

// Used to handle upload and download of data other than the user from database
import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

class DataService
{
    //MARK: PROPERTIES
    static var instance = DataService()
    private var REF_POSTS = DB_BASE.collection("posts")
    @AppStorage(CurrentUserDefaults.userID) var currentUserID : String?
    
    //MARK: FUNCTIONS
    func uploadPost(image : UIImage , caption :  String? , displayName : String , userID : String , handler : @escaping(_ success : Bool) -> ())
    {
        //Create new document
        var document = REF_POSTS.document()
        var postID = document.documentID
        
        //Upload Image to Storage
        ImageManager.instance.uploadPostImage(postID: postID, image: image) { success in
            if success
            {
                //Successfully uploaded data to Storage
                let postData : [String : Any] = [
                    DatabasePostsField.postID : postID ,
                    DatabasePostsField.userID : userID ,
                    DatabasePostsField.displayName : displayName ,
                    DatabasePostsField.caption : caption ?? "",
                    DatabasePostsField.dateCreated : FieldValue.serverTimestamp() ,
                    DatabasePostsField.likeCount : 0 ,
                    DatabasePostsField.likedBy : []
                ]
                
                document.setData(postData) { error in
                    if let err = error
                    {
                        print("Error Uploading data to Post documents")
                        handler(false)
                        return
                    }
                    else
                    {
                        handler(true)
                        return
                    }
                }
            }
            else
            {
                print("Error uploading posts to database")
                handler(false)
                return
            }
        }
    }
    
    func uploadComments(postID : String , content : String , displayName : String , userID : String ,  handler : @escaping(_ success : Bool , _ commentID : String? ) -> () )
    {
        let document = REF_POSTS.document(postID).collection(DatabasePostsField.comments).document()
        let commentID = document.documentID
        
        let data : [String : Any] = [ DatabaseCommentsField.commentID : commentID ,
                                      DatabaseCommentsField.userID : userID ,
                                      DatabaseCommentsField.displayName : displayName ,
                                      DatabaseCommentsField.dateCreated : FieldValue.serverTimestamp() ,
                                      DatabaseCommentsField.content : content]
        document.setData(data) { error in
            if let error = error
            {
                print("Error Uploading Comments")
                handler(false, nil)
                return
            }
            else
            {
                handler(true,commentID)
                return
            }
        }
    }
    
    //MARK: GET FUNCTIONS
    func downloadPostForUser(userID : String , handler : @escaping(_ posts : [PostModel]) -> ())
    {
        REF_POSTS.whereField(DatabasePostsField.userID , isEqualTo: userID).getDocuments { querySnapshot , error in
            handler(self.getPostsFromSnapshot(querySnapshot: querySnapshot))
        }
    }
    
    func downloadPostForFeed(handler : @escaping(_ posts : [PostModel]) -> ())
    {
        REF_POSTS.order(by: DatabasePostsField.dateCreated , descending : true ).limit(to : 10).getDocuments { querySnapshot , error in
            handler(self.getPostsFromSnapshot(querySnapshot: querySnapshot))
        }
    }
    
    func downloadComments(postID : String ,  handler : @escaping(_ comments : [CommentModel]) -> () )
    {
        REF_POSTS.document(postID).collection(DatabasePostsField.comments).order(by: DatabaseCommentsField.dateCreated, descending: false).getDocuments { (querySnapshot, error) in
            handler(self.getCommentsFromSnapshot(querySnapshot: querySnapshot))
        }
    }
    
    private func getCommentsFromSnapshot(querySnapshot : QuerySnapshot?) -> [CommentModel]
    {
        var commentArray = [CommentModel]()
        if let snapshot = querySnapshot, snapshot.documents.count > 0
        {
            for document in snapshot.documents
            {
                if
                    let userID = document.get(DatabaseCommentsField.userID) as? String,
                    let displayName = document.get(DatabaseCommentsField.displayName) as? String,
                    let content = document.get(DatabaseCommentsField.content) as? String,
                    let timestamp = document.get(DatabaseCommentsField.dateCreated) as? Timestamp
                {
                    let date = timestamp.dateValue()
                    let commentID = document.documentID
                    let newComment = CommentModel(commentId: commentID, userId: userID, username: displayName, content: content, dateCreated: date)
                    commentArray.append(newComment)
                }
            }
            return commentArray
        }
        else
        {
            print("No comments in document for this post")
            return commentArray
        }
    }
    
    private func getPostsFromSnapshot(querySnapshot : QuerySnapshot?) -> [PostModel]
    {
        var posts = [PostModel]()
        
        if let snapshot = querySnapshot , snapshot.documents.count > 0
        {
            for document in snapshot.documents
            {
                let postID = document.documentID
                if
                    let userID = document.get(DatabasePostsField.userID) as? String ,
                    let displayName = document.get(DatabasePostsField.displayName) as? String ,
                    let timestamp = document.get(DatabasePostsField.dateCreated) as? Timestamp
                    {
                    
                        let caption = document.get(DatabasePostsField.caption) as? String
                        let time = timestamp.dateValue()
                        let likeCount = document.get(DatabasePostsField.likeCount) as? Int ?? 0
                    
                        var likedByUser : Bool = false
                        if let userIDArray = document.get(DatabasePostsField.likedBy) as? [String] , let userID = currentUserID
                        {
                            userIDArray.contains(userID)
                            likedByUser = userIDArray.contains(userID)
                        }
                    
                        let newPost = PostModel(postId: postID, userId: userID, username: displayName, caption: caption, likeCount: likeCount, dateCreate: time, likedByUser: likedByUser)
                        posts.append(newPost)
                    }
            }
            return posts
        }
        else
        {
            print("No Documents for this particular User")
            return posts
        }
    }
    
    //MARK: UPDATE FUNCTIONS
    func likePost(postID : String , currentUserID : String)
    {
        // Update the like count
        // Update the array of users who liked the post
        if DatabasePostsField.likedBy.contains(currentUserID)
        {
            unLikePost(postID: postID, currentUserID: currentUserID)
            return
        }
            
        let inc : Int64 = 1
        let data : [String : Any] = [   DatabasePostsField.likeCount : FieldValue.increment(inc) ,
                                        DatabasePostsField.likedBy : FieldValue.arrayUnion([currentUserID]) ]
        
        REF_POSTS.document(postID).updateData(data)
    }
    
    func unLikePost(postID : String , currentUserID : String)
    {
        // Update the like count
        // Update the array of users who liked the post
        
        let dec : Int64 = -1
        let data : [String : Any] = [   DatabasePostsField.likeCount : FieldValue.increment(dec) ,
                                        DatabasePostsField.likedBy : FieldValue.arrayUnion([currentUserID]) ]
        
        REF_POSTS.document(postID).updateData(data)
    }
    
    func updateDisplayNameOnDisplay(userID : String , displayName : String)
    {
        downloadPostForUser(userID: userID) { returnedPosts in
            for post in returnedPosts {
                self.updateDisplayName(postID: post.postId, displayName: displayName)
            }
        }
    }
    
    private func updateDisplayName(postID : String , displayName : String)
    {
        let data : [String : Any]  = [ DatabasePostsField.displayName : displayName]
        REF_POSTS.document(postID).updateData(data)
    }
}

