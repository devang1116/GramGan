//
//  OnboardingView2.swift
//  social media
//
//  Created by Devang Papinwar on 30/10/21.
//

import SwiftUI

struct OnboardingView2: View
{
    @Binding var displayName : String
    @Binding var email : String
    @Binding var provider : String
    @Binding var providerID : String
    @State var showImagePicker : Bool = false
    
    @State var imageSelected : UIImage = UIImage(imageLiteralResourceName: "logo")
    @State var sourceType : UIImagePickerController.SourceType = .photoLibrary
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View
    {
        VStack(alignment: .center, spacing: 20)
        {
            Text("What's your Name ?")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.yellow)
            
            TextField(" ", text: $displayName)
                .padding()
                .frame(height:60)
                .frame(maxWidth : .infinity)
                .background(Color.gray)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.sentences)
                .padding(.horizontal)

            
            Button {
                showImagePicker.toggle()
            } label: {
                Text("Finish : Add your Profile Picture")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height:60)
                    .frame(maxWidth:.infinity)
                    .background(Color.yellow)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            .accentColor(.purple)
            .opacity(displayName != "" ? 1.0 : 0.0 )
            .animation(.easeInOut(duration: 1.0))
        }
        .frame(maxWidth:.infinity , maxHeight:.infinity)
        .background(Color.purple)
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showImagePicker , onDismiss: createProfile , content: {
            ImagePicker(imageSelected: $imageSelected, sourceType: $sourceType)
        })

    }
    
    //MARK: Functions
    func createProfile()
    {
        print("New Profile is created")
        AuthService.instance.createNewUserInDatabase(name: displayName, email: email, providerID: providerID, provider: provider, profileImage: imageSelected) { returnedUserId in
            if let userId = returnedUserId {
                print("Succesfully Logged in")
                
                
                AuthService.instance.logInUserToApp(userID: userId) { success in
                    if success
                    {
                        print("User Logged in")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) {
                            self.presentationMode.wrappedValue.dismiss()
                        }

                    }
                    else
                    {
                        print("Error loggin in")
                    }
                }
            }
            else
            {
                print("Error creating Database")
            }
        }
    }
}

struct OnboardingView2_Previews: PreviewProvider
{
    @State static var testString : String = "TestString"
    static var previews: some View
    {
        OnboardingView2(displayName: $testString, email: $testString, provider: $testString, providerID: $testString)
    }
}
