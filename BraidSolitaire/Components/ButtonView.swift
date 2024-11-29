//
//  ButtonView.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 29.11.24.
//

import SwiftUI

struct ButtonView: View {
   // var action: () -> Void
    var text: String = "Click on me"
    var body: some View {
        VStack {
            
            Text(text)
                .font(.title2)
                .padding()
          //      .background(Color("BraidGreen"), in: RoundedRectangle(cornerRadius: 25))
                .background(
                    ZStack{
                        Color("BraidGreenShadow")
                        
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.gray)
                            .blur(radius: 4)
                            .offset(x: -8, y: -8)
                        
                        RoundedRectangle(cornerRadius: 25)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color("BraidGreen"), Color("BraidGreen2")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .padding(2)
                            .blur(radius: 2)
                    }
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .shadow(color: Color("BraidGreenShadow"), radius: 20, x: 20, y: 20)
                        .shadow(color: .gray, radius: 20, x:-20, y: -20)
                    
                )
              
        }
        .tint(.white)
    }
}

//#Preview {
//    ButtonView(action: <#T##() -> Void#>)
//}
