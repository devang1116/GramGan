//
//  SettingsEditTextView.swift
//  social media
//
//  Created by Devang Papinwar on 30/10/21.
//

import SwiftUI

struct SettingsEditTextView: View
{
    @State var submissionText : String = ""
    @State var title : String
    @State var placeholder : String
    @State var description : String
    
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

struct SettingsEditTextView_Previews: PreviewProvider
{
    static var previews: some View
    {
        NavigationView
        {
            SettingsEditTextView(title: "This is a Description", placeholder: "Test Placeholder", description: "Bro this just the description")
        }
    }
}
