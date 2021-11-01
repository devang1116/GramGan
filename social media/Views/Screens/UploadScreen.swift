//
//  UploadScreen.swift
//  social media
//
//  Created by Devang Papinwar on 29/10/21.
//

import SwiftUI
import UIKit

struct UploadScreen: View
{
    @State var showImagePicker : Bool = false
    @State var imageSelected: UIImage = UIImage(named: "logo")!
    @State var sourceType : UIImagePickerController.SourceType = .camera
    @State var showPostImageView: Bool = false
    
    var body: some View
    {
        ZStack
        {
            VStack
            {
                Button (action:{
                    sourceType = UIImagePickerController.SourceType.camera
                    showImagePicker.toggle()
                } , label: {
                    Text("Take Photo".uppercased())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.yellow)
                })
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(Color.purple)
                
                Button (action:{
                    sourceType = UIImagePickerController.SourceType.photoLibrary
                    showImagePicker.toggle()
                } , label: {
                    Text("Import Photo".uppercased())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.purple)
                })
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(Color.yellow)
                
            }
            .edgesIgnoringSafeArea(.top)
            .sheet(isPresented: $showImagePicker, onDismiss: segueToPostImageView, content: {
                ImagePicker(imageSelected: $imageSelected, sourceType: $sourceType )
            })
            
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
                .shadow(radius: 12)
                .fullScreenCover(isPresented: $showPostImageView , content : {
                    PostImageView(imageSelected: $imageSelected)
                })
        }
    }
    // MARK: FUNCTIONS

    func segueToPostImageView()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
        {
            showPostImageView.toggle()
        }
    }

}



struct UploadScreen_Previews: PreviewProvider
{
    static var previews: some View
    {
        UploadScreen()
    }
}
