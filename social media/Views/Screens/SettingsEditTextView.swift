//
//  SettingsEditTextView.swift
//  social media
//
//  Created by Devang Papinwar on 30/10/21.
//

import SwiftUI

struct SettingsEditTextView: View
{
    @Environment(\.presentationMode) var presentationMode
    @State var submissionText : String = ""
    @State var title : String
    @State var placeholder : String
    @State var description : String
    @State var settingsEditTextOption : SettingsEditTextOption
    @Binding var profileText : String
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID : String?
    
    @State var showAlert : Bool = false
    
    var body: some View
    {
        VStack
        {
            Text(description)

            TextField(placeholder, text: $submissionText)
                .padding()
                .frame(height:60)
                .frame(maxWidth:.infinity)
                .background(Color.gray)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.sentences)
                .accentColor(Color.white)
            
            Button {
                saveText()
            } label: {
                Text("Save")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height:60)
                    .frame(maxWidth:.infinity)
                    .background(Color.purple)
                    .cornerRadius(12)
                    
            }
            .accentColor(Color.white)

            Spacer()
        }
        .navigationBarTitle(title)
        .padding()
        .alert(isPresented: $showAlert) { () -> Alert in
            return Alert(title: Text("Saved"), message: nil, dismissButton: .default(Text("Ok"), action: {
                self.presentationMode.wrappedValue.dismiss()
            }))
        }

    }
    
    //MARK: FUNCTIONS
    func saveText()
    {
        guard let userID = currentUserID else
        {
            return
        }
        switch settingsEditTextOption
        {
        case .displayName :
            // Update the UI on Profile
            self.profileText = submissionText
            
            // Update the UserDefaults
            UserDefaults.standard.setValue(submissionText, forKey: CurrentUserDefaults.displayName)
            
            // Update on all User's Posts
            DataService.instance.updateDisplayNameOnDisplay(userID: userID, displayName: submissionText)
            
            //Update the user's profile in Database
            AuthService.instance.updateUserDisplayName(userID: userID, displayName: submissionText) { success in
                if success
                {
                    self.showAlert.toggle()
                }
            }
        case .bio :
            // Update the UI on Profile
            self.profileText = submissionText
            
            // Update the UserDefaults
            UserDefaults.standard.set(submissionText, forKey: CurrentUserDefaults.bio)
            
            //Update the user's profile in Database
            AuthService.instance.updateUserBio(userID: userID, bio: submissionText) { success in
                if success
                {
                    self.showAlert.toggle()
                }
            }
        }
    }
}

struct SettingsEditTextView_Previews: PreviewProvider
{
    @State static var text : String = " "
    static var previews: some View
    {
        NavigationView
        {
            SettingsEditTextView(title: "This is a Description", placeholder: "Test Placeholder", description: "Bro this just the description", settingsEditTextOption: .displayName, profileText: $text)
        }
    }
}
