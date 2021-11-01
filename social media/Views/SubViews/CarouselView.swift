//
//  CarouselView.swift
//  social media
//
//  Created by Devang Papinwar on 29/10/21.
//

import SwiftUI

struct CarouselView: View
{
    @State var selection : Int = 0
    var body: some View
    {
        TabView(selection: $selection,
                content: {
            ForEach(1..<8, content: { count in
                Image("dog\(count)")
                    .resizable()
                    .scaledToFit()
                    .tag(0)
            })
            
                
        })
            .tabViewStyle(PageTabViewStyle())
            .frame(height:300)
            .animation(.default)
            .onAppear(perform : {
                addTimer()
            })
    }
    
    func addTimer()
    {
        let timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { (timer) in
            selection = selection + 1
        }
        timer.fire()
    }
}

struct CarouselView_Previews: PreviewProvider
{
    static var previews: some View
    {
        CarouselView()
    }
}
