//
//  PostModel.swift
//  social media
//
//  Created by Devang Papinwar on 28/10/21.
//

import Foundation
import SwiftUI

struct PostModel : Hashable , Identifiable
{
    var id = UUID()
    var postId : String
    var userId : String
    var username : String
    var caption : String?
    var likeCount : Int
    var dateCreate : Date
    var likedByUser : Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
