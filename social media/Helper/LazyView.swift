//
//  LazyView.swift
//  social media
//
//  Created by Devang Papinwar on 02/11/21.
//

import Foundation
import SwiftUI

struct LazyView<Content : View> : View
{
    var content : () -> Content
    
    var body: some View
    {
        self.content()
    }
}
