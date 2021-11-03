//
//  Enums & Structs.swift
//  social media
//
//  Created by Devang Papinwar on 31/10/21.
//

import Foundation

struct DatabaseUserFields
{
    static let display_name = "display_name"
    static let email = "email"
    static let provider = "provider"
    static let provider_id = "provider_id"
    static let user_id = "user_id"
    static let bio = "bio"
    static let date_created = "date_created"

}

struct CurrentUserDefaults
{
    static let displayName = "display_name"
    static let bio = "bio"
    static let userID = "user_id"
}

// Fields within Post Document
struct DatabasePostsField
{
    static let postID = "post_id"
    static let userID = "user_id"
    static let displayName = "display_name"
    static let caption = "caption"
    static let dateCreated = "data_created"
    static let likedBy = "liked_by"         // ARRAY
    static let likeCount = "like_count"  // INT
    static let comments = "comments"      // SUB COLLECTION
}

// Fields within Comment Sub Collection of a Post
struct DatabaseCommentsField
{
    static let commentID = "comment_id"
    static let displayName = "display_name"
    static let userID = "user_id"
    static let content = "content"
    static let dateCreated = "data_created"
}

// Updating the User Profile Data

enum SettingsEditTextOption
{
   case displayName
    case bio
}
