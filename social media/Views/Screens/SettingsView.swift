//
//  SettingsVIew.swift
//  social media
//
//  Created by Devang Papinwar on 30/10/21.
//

import SwiftUI

struct SettingsView: View
{
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var userBio : String
    @Binding var userName : String
    @Binding var userProfilePicture : UIImage
    var body: some View
    {
        NavigationView
        {
            ScrollView(.vertical, showsIndicators: false)
            {
                //MARK: Section 1 : Gram
                GroupBox {
                    HStack(alignment: .center, spacing: 10, content: {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80, alignment: .center)
                            .cornerRadius(12)
                        
                        Text("Your GoTo Alternative for Social Media")
                            .font(.footnote)
                    })
                    
                } label: {
                    SettingsLabelView(labelText: "Gram", labelImage: "dot.radiowaves.left.and.right")
                }
                .padding()
                
                //MARK: Section 2 : Profile
                GroupBox {
                    
                } label: {
                    
                        SettingsLabelView(labelText: "Profile", labelImage: "person.fill")
                        
                        NavigationLink {
                            SettingsEditTextView(submissionText: userName, title: "Display Name", placeholder: "Your Display Name here", description: "You can edit your Display Name here" , settingsEditTextOption: .displayName , profileText: $userName)
                        } label: {
                            SettingsRowView(leftIcon: "pencil", rowTitle: "Display Name", color: Color("Purple"))
                        }
                        Divider()
                        
                        NavigationLink {
                            SettingsEditTextView(submissionText: userBio, title: "Bio", placeholder: "your Bio here", description: "Your Bio can be changed here" , settingsEditTextOption: .bio , profileText: $userBio)
                        } label: {
                            SettingsRowView(leftIcon: "text.quote", rowTitle: "Bio", color: Color("Purple"))
                        }
                        Divider()
                        
                        NavigationLink {
                             SettingsEditImageView(title: "Profile Picture", description: "You can change your Profile picture here", selectedImage: userProfilePicture, profileImage: $userProfilePicture, showImagePicker: true)
                        } label: {
                            SettingsRowView(leftIcon: "photo", rowTitle: "Profile", color: Color("Purple"))
                        }
                    
                        Divider()
                    
                        Button {
                            signOut()
                        } label: {
                            SettingsRowView(leftIcon: "figure.walk", rowTitle: "Sign out", color: Color("Purple"))
                        }

                        
                        
                        
                }
                .padding()

                //MARK: Section 3 : Application
                GroupBox {
                    
                } label: {
                    
                    SettingsLabelView(labelText: "Application", labelImage: "app")
                    Button {
                        openURL(urlString: "https://www.udemy.com")
                    } label: {
                        SettingsRowView(leftIcon: "folder.fill", rowTitle: "Privacy Policy", color: Color("Yellow"))
                    }
                    
                    Button {
                        
                    } label: {
                        SettingsRowView(leftIcon: "folder.fill", rowTitle: "Terms and Conditions", color: Color("Yellow"))
                    }
                    
                    Button {
                        
                    } label: {
                        SettingsRowView(leftIcon: "globe", rowTitle: "Gram's Website", color: Color("Yellow"))
                    }




                }
                .padding()

                //MARK: Section 4 : Sign Off
                GroupBox {
                    Text("Version 1.1")
                }
                .padding()
            }
            .navigationBarTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.body)
            }))
        }
    }
    
    //MARK: Function
    func openURL(urlString : String)
    {
        guard let url = URL(string: urlString) else { return }
        
        if UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.open(url)
        }
    }
    
    func signOut()
    {
        AuthService.instance.logOutUser { success in
            if success
            {
                print("Successfully Logged Out")
                self.presentationMode.wrappedValue.dismiss()
                
                
            }
            else
            {
                print("Error signing out")
            }
        }
    }
}

struct SettingsVIew_Previews: PreviewProvider
{
    @State static var testString : String = " "
    @State static var testImage : UIImage = UIImage(named: "dog1")!
    static var previews: some View
    {
        SettingsView(userBio: $testString, userName: $testString, userProfilePicture: $testImage)
    }
}
