//
//  social_mediaApp.swift
//  social media
//
//  Created by Devang Papinwar on 28/10/21.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct social_mediaApp: App
{
    let signInConfig = GIDConfiguration.init(clientID: "754643068806-qdud9dq16f1h2765dln170ol8u0tebfp.apps.googleusercontent.com")
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    init()
    {
        FirebaseApp.configure()
    }
    var body: some Scene
    {
        WindowGroup
        {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate
{
    func application(
      _ app: UIApplication,
      open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
      var handled: Bool

      handled = GIDSignIn.sharedInstance.handle(url)
      if handled {
        return true
      }

      // Handle other custom URL types.

      // If not handled by this app, return false.
      return false
    }
    
    func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let signInConfig = GIDConfiguration.init(clientID: "754643068806-qdud9dq16f1h2765dln170ol8u0tebfp.apps.googleusercontent.com")
        
      GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
        if error != nil || user == nil {
          // Show the app's signed-out state.
        } else {
          // Show the app's signed-in state.
        }
      }
      return true
    }
    
    
}
