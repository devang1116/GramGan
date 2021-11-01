//
//  SettingsLabelView.swift
//  social media
//
//  Created by Devang Papinwar on 30/10/21.
//

import SwiftUI

struct SettingsLabelView: View
{
    var labelText : String
    var labelImage : String
    
    var body: some View
    {
        VStack
        {
            HStack
            {
                Text(labelText)
                    .font(.body)
                
                Spacer()
                
                Image(systemName: labelImage)
            }
            .padding(.horizontal)
            Divider()
        }
    }
}

struct SettingsLabelView_Previews: PreviewProvider
{
    static var previews: some View
    {
        SettingsLabelView(labelText: "Settings", labelImage: "heart")
    }
}
