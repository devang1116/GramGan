//
//  SettingsEditImageView.swift
//  social media
//
//  Created by Devang Papinwar on 30/10/21.
//

import SwiftUI

struct SettingsEditImageView: View
{
    @State var title : String
    @State var description : String
    @State var selectedImage : UIImage
    @Binding var profileImage : UIImage //
    @State var sourceType = UIImagePickerController.SourceType.photoLibrary
    @State var showAlert : Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID : String?
    
    @State var showImagePicker : Bool
    
    var body: some View
    {
        VStack
        {
            Text(description)
            
            Image(uiImage: selectedImage)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200, alignment: .center)
                .clipped()
                .cornerRadius(12)
                
            
            Button {
                showImagePicker.toggle()
            } label: {
                Text("Import")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height:60)
                    .frame(maxWidth:.infinity)
                    .background(Color.yellow)
                    .cornerRadius(12)
                    
            }
            .accentColor(Color.white)
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(imageSelected: $selectedImage, sourceType: $sourceType)
            }

            
            Button {
                saveImage()
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
    func saveImage()
    {
        guard let userID = currentUserID else { return }
        // Update the UI of Profile
        self.profileImage = selectedImage
        
        // Update profile image in Database
        ImageManager.instance.uploadProfileImage(userID: userID, image: selectedImage)
        
        self.showAlert.toggle()
    }
}

struct SettingsEditImageView_Previews: PreviewProvider
{
    @State static var image : UIImage = UIImage(named: "dog1")!
    static var previews: some View
    {
        NavigationView
        {
            SettingsEditImageView(title: "Profile Picture", description: "You can change your Profile Picture here", selectedImage: UIImage(named:"dog1")!, profileImage: $image, showImagePicker: true)
        }
    }
}
