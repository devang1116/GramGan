//
//  PostImageView.swift
//  social media
//
//  Created by Devang Papinwar on 29/10/21.
//

import SwiftUI

struct PostImageView: View
{
    @Environment(\.presentationMode) var presentationMode
    @State var captionText : String = ""
    @Binding var imageSelected : UIImage
    
    var body: some View
    {
        VStack(alignment: .center, spacing: 0, content: {
            HStack
            {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .padding()
                }
                Spacer()
            }
            
            ScrollView(.vertical, showsIndicators: false, content: {
                Image(uiImage: imageSelected)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200, alignment: .center)
                    .cornerRadius(12)
                    .clipped()
                
                TextField("Add you Text here", text: $captionText)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .frame( height: 60)
                    .frame( maxWidth : .infinity )
                    .background(Color.gray )
                    .font(.headline)
                    .autocapitalization(.sentences)
                
                Button {
                    
                } label: {
                    Text("Post Picture!".uppercased())
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding()
                        .frame(height:60)
                        .frame(maxWidth : .infinity)
                        .cornerRadius(12)
                        .background(Color.purple)
                        .padding(.horizontal)

                }

            })
        })
            .accentColor(.primary)
           
    }
    
    func postPicture()
    {
        print("Post Picture to Database")
    }
}

struct PostImageView_Previews: PreviewProvider
{
    @State static var image : UIImage = UIImage(named: "dog1")!
    static var previews: some View
    {
        PostImageView(imageSelected: $image)
    }
}
