//
//  SignUpView.swift
//  social media
//
//  Created by Devang Papinwar on 30/10/21.
//

import SwiftUI

struct SignUpView: View
{
    @State var showOnBoardingView : Bool = false
    var body: some View
    {
        VStack(alignment: .center, spacing: 20)
        {
            Spacer()
            
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
            
            Text("You aint Signed in Dawg")
                .font(.title)
                .fontWeight(.bold)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            
            Text("Click to proceed to Create an Account")
            
            Button {
                showOnBoardingView.toggle()
            } label: {
                Text("Sign In / Sign Up")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth : .infinity)
                    .background(Color.purple)
                    .cornerRadius(12)
                    .shadow( radius: 12)
                    .foregroundColor(Color.yellow)
            }
            
            Spacer()
            Spacer()
        }
        .padding(.all,40)
        .background(Color.yellow)
        .edgesIgnoringSafeArea(.top)
        .fullScreenCover(isPresented: $showOnBoardingView) {
            OnboardingView()
        }
    }
}

struct SignUpView_Previews: PreviewProvider
{
    static var previews: some View
    {
        SignUpView()
    }
}
