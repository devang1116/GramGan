//
//  SignInWithGoogle.swift
//  social media
//
//  Created by Devang Papinwar on 30/10/21.
//
//

import SwiftUI
import GoogleSignIn
import Firebase

class SignInWithGoogle {
    
    static let instance = SignInWithGoogle()
    var onboardingView: OnboardingView!
    
    func startSignInWithGoogleFlow(view: OnboardingView) {
        self.onboardingView = view
        googleSignIn()
  
    }
    
    func googleSignIn()
    {
        print("ITHE ALO KA ME")
           guard let clientID = FirebaseApp.app()?.options.clientID else { return }
           
           // Create Google Sign In configuration object.
           let config = GIDConfiguration(clientID: clientID)
           
           // Start the sign in flow!
           GIDSignIn.sharedInstance.signIn(with: config, presenting: (UIApplication.shared.windows.first?.rootViewController)!) { user, error in

             if let error = error {
                 print("User Cancelled")
               print(error.localizedDescription)
               return
             }
               let fullName = user?.profile?.name
               let email = user?.profile?.email
             guard
               let authentication = user?.authentication,
               let idToken = authentication.idToken
             else {
               return
             }

               let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                               accessToken: authentication.accessToken)
               
               print("User \(email) \(fullName) ")

               // Authenticate with Firebase using the credential object
               Auth.auth().signIn(with: credential) { (authResult, error) in
                   if let error = error {
                       self.onboardingView.showError.toggle()
                       return
                   }
                   print(authResult ?? "none")
                   //self.onboardingView.connectToFirebase(name: fullName, email: email, provider: "google", credential: credential)
                   self.onboardingView.connectToFirebase(name: fullName ?? " ", email: email ?? " ", provider: "google", credential: credential)
               }
               
             
           }
       }
    
    func googleSignIn(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
            // Perform any operations when the user disconnects from app here.
            // ...
            print("USER DISCONNECTED FROM GOOGLE")
            self.onboardingView.showError.toggle()
        }
   }
