//
//  CommentModel.swift
//  social media
//
//  Created by Devang Papinwar on 28/10/21.
//

import Foundation
import SwiftUI

struct CommentModel : Identifiable ,  Hashable
{
    var id = UUID()
    var commentId : String
    var userId : String
    var username : String
    var content : String
    var dateCreated : Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
