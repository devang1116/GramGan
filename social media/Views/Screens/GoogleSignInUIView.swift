//
//  GoogleSignInUIView.swift
//  social media
//
//  Created by Devang Papinwar on 31/10/21.
//

import Foundation
import SwiftUI
import UIKit
import GoogleSignIn
import Firebase

struct GoogleSignIn : UIViewControllerRepresentable
{
    let signInConfig = GIDConfiguration.init(clientID: "754643068806-qdud9dq16f1h2765dln170ol8u0tebfp.apps.googleusercontent.com")
    
    func makeUIViewController(context: Context) -> UIFontPickerViewController {
            return UIFontPickerViewController()
        }
        
        // 3.
        func updateUIViewController(_ uiViewController: UIFontPickerViewController, context: Context) {
            
        }
    
        func signIn(sender: Any) {
            GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: UIApplication.shared.windows.first!.rootViewController!) { user, error in
            guard error == nil else { return }

            // If sign in succeeded, display the app's main content View.
          }
        }
}

/// https://socialmedia-dd00d.firebaseapp.com/__/auth/handler
