//
//  OnboardingView.swift
//  social media
//
//  Created by Devang Papinwar on 30/10/21.
//

import SwiftUI
import Firebase
import AuthenticationServices
import GoogleSignIn
import FirebaseAuth


struct OnboardingView: View
{
    @State var displayName : String = ""
    @State var email : String = ""
    @State var provider : String = ""
    @State var providerID : String = ""
    
    
    let signInConfig = GIDConfiguration.init(clientID: "754643068806-qdud9dq16f1h2765dln170ol8u0tebfp.apps.googleusercontent.com")
    @Environment(\.presentationMode) var presentationMode
    @State var showOnBoarding2 : Bool = false
    @State var showError : Bool = false
    //@State var email : String = ""
    
    var body: some View
    {
        VStack(spacing : 20)
        {
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
                .shadow(radius: 12)
           
            Text("Welcome to GramGan")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
            
            Text("GramGang is your fav Social Media Alternative.")
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.black)
            
            Button {
                showOnBoarding2.toggle()

            } label: {
                SignInWithApple()
                    .frame(height:60)
                    .frame(maxWidth : .infinity)
            }
            
            Button {
                SignInWithGoogle.instance.startSignInWithGoogleFlow(view: self)
                SignInWithGoogle.instance.googleSignIn()
                
                
            
                    
            } label: {
                HStack
                {
                    Image(systemName: "globe")
                    Text("Sign in with Gmail")
                        .foregroundColor(Color.white)
                }
                .frame(height:60)
                .frame(maxWidth : .infinity)
                .background(Color(.sRGB, red: 222/255, green: 82/255, blue: 70/255, opacity: 1.0))
                .cornerRadius(6)
                .font(.system(size: 23, weight: .medium, design: .default))
            }
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack
                {
                    Text("Continue as Guest")
                }
                .frame(height:60)
                .frame(maxWidth : .infinity)
          
            }

        }
        .padding()
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $showOnBoarding2 , onDismiss: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            OnboardingView2(displayName: $displayName, email: $email, provider: $provider, providerID: $providerID)
        }
    }
    
    //MARK: Functions
    func connectToFirebase(name: String , email :String , provider: String , credential : AuthCredential)
    {

        
        print("YOOOOOOOOOOOOOOOOOOOOO")
        AuthService.instance.logInUserToFirebase(credential: credential) { returnedProviderID, isError, isNewUser , returnedUserID   in
            
            if let newUser = isNewUser
            {
                if newUser
                {
                    if let providerID = returnedProviderID , !isError {
                        
                        print("Hell Yeah")
                        self.displayName = name
                        self.email = email
                        self.providerID = providerID
                        self.provider = provider
                        self.showOnBoarding2.toggle()
                    }
                    else
                    {
                        print("Erroe getting providerID info from logged in Databse")
                        self.showError.toggle()
                    }
                }
                else
                {
                    if let userID = returnedUserID
                    {
                        AuthService.instance.logInUserToApp(userID: userID) { success in
                            if success
                            {
                                print("Successful Login")
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            else
                            {
                                print("Errpr loggin in existing users")
                            }
                        }
                    }
                    else
                    {
                        
                    }
                }
            }
            else
            {
                print("Erroe getting info from logged in Databse")
                self.showError.toggle()
            }
            
            
        }
        
    }
}



struct OnboardingView_Previews: PreviewProvider
{
    static var previews: some View
    {
        OnboardingView()
    }
}


