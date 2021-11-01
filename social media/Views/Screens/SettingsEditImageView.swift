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
    @State var sourceType = UIImagePickerController.SourceType.photoLibrary
    
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

    }
}

struct SettingsEditImageView_Previews: PreviewProvider
{
    static var previews: some View
    {
        NavigationView
        {
            SettingsEditImageView(title: "Profile Picture", description: "You can change your Profile Picture here", selectedImage: UIImage(named:"dog1")!, showImagePicker: true)
        }
    }
}
