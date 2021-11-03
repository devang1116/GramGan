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
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID : String?
    @AppStorage(CurrentUserDefaults.displayName) var currentDisplayName : String?
    
    @State var showAlert : Bool = false
    @State var postUpdatedSuccessfully : Bool = false
    
    var body: some View
    {
        VStack(alignment: .center, spacing: 0, content: {
            HStack
            {
                Button
                {
                    presentationMode.wrappedValue.dismiss()
                } label:
                {
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
                    .background(Color("Beige"))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .frame( height: 60)
                    .frame( maxWidth : .infinity )
                    .font(.headline)
                    .textFieldStyle(SuperCustomTextFieldStyle())
                    .autocapitalization(.sentences)
                
                Button
                {
                    postPicture()
                } label: {
                    Text("Post Picture!".uppercased())
                        .font(.title3)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .padding()
                        .frame(height:60)
                        .frame(maxWidth : .infinity)
                        .cornerRadius(12)
                        .background(Color("Purple"))
                        .padding(.horizontal)

                }

            })
                .alert(isPresented: $showAlert) {
                    getAlert()
                }
        })
            .accentColor(Color("Purple"))
           
    }
    
    // Uploads Posts to to Database
    func postPicture()
    {
        print("Post Picture to Database")
        
        guard let userID = currentUserID , let displayName = currentDisplayName else {
            print("Error getting UserID of displayName of User")
            return
        }
        
        DataService.instance.uploadPost(image: imageSelected, caption: captionText, displayName: currentDisplayName ?? " ", userID: currentUserID ?? " " ) { success in
            self.postUpdatedSuccessfully = success
            self.showAlert.toggle()
            
        }
    }
    
    func getAlert() -> Alert
    {
        if postUpdatedSuccessfully
        {
            return Alert(title: Text("Post Updated Successfully"), message: nil, dismissButton: .default(Text("Ok") , action: {
                self.presentationMode.wrappedValue.dismiss()
            }))
        }
        else
        {
            return Alert(title: Text("Post Update Not Successful"), message: nil, dismissButton: .default(Text("Ok")))
        }
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
