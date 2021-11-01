//
//  SettingsRowView.swift
//  social media
//
//  Created by Devang Papinwar on 30/10/21.
//

import SwiftUI

struct SettingsRowView: View
{
    var leftIcon : String
    var rowTitle : String
    var color :Color
    
    var body: some View
    {
        HStack
        {
            ZStack
            {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)

                    
                Image(systemName: leftIcon)
                    .font(.title3)
                    .foregroundColor(Color.white)
                
            }
            .frame(width: 36, height: 36, alignment: .center)
            
            Text(rowTitle)
                .foregroundColor(.primary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.primary)
                .font(.headline)
        }
        .padding(.horizontal)
    }
}

struct SettingsRowView_Previews: PreviewProvider
{
    static var previews: some View
    {
        SettingsRowView(leftIcon: "heart.fill", rowTitle: "Row Title Gang", color: .red)
    }
}
