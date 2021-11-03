//
//  SigninWithAppleCustomButton.swift
//  social media
//
//  Created by Devang Papinwar on 30/10/21.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct SignInWithApple : UIViewRepresentable
{
    func makeUIView(context: Context) -> some UIView {
        return ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .black)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
