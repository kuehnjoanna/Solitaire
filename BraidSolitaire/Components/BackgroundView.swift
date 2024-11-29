//
//  BackgroundView.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 29.11.24.
//

import SwiftUI

struct BackgroundView: View {
    
    @State var animationGradient = false
    var body: some View {
        ZStack{
        LinearGradient(colors: [Color("BraidGreenShadow"), Color("BraidGreen")], startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            .hueRotation(.degrees(animationGradient ? 20 : 0))
            .onAppear{
                withAnimation(.easeInOut(duration: 8).repeatForever(autoreverses: true)){
                    animationGradient.toggle()
                }
            }
            GeometryReader { proxy in
                let size = proxy.size
                Color.black
                    .opacity(0.7)
                    .blur(radius: 200)
                    .ignoresSafeArea()
                
                Circle()
                    .fill(.green)
                    .padding(50)
                    .blur(radius: 120)
                //moving top
                    .offset(x: -size.width / 1.8, y: -size.height / 5)
                    .offset(x: animationGradient ? -40 : 140)
                    .offset(y: animationGradient ? 40 : 140)
                
                Circle()
                    .fill(.green)
                    .padding(50)
                    .blur(radius: 150)
                //moving top
                    .offset(x: size.width / 1.8, y: -size.height / 2)
                Circle()
                    .fill(.black)
                    .padding(50)
                    .blur(radius: 90)
                //moving top
                    .offset(x: size.width / 1.8, y: size.height / 2)
                    .offset(x: animationGradient ? -10 : 70)
                    .offset(y: animationGradient ? -40 : -140)
                
                Circle()
                    .fill(.green)
                    .padding(100)
                    .blur(radius: 110)
                //moving top
                    .offset(x: size.width / 1.8, y: size.height / 2)
                    .offset(x: animationGradient ? 70 : -120)
                    .offset(y: animationGradient ? 80 : 114)
                
                Circle()
                    .fill(.green)
                    .padding(100)
                    .blur(radius: 110)
                //moving top
                    .offset(x: -size.width / 1.8, y: size.height / 5)
                    .offset(x: animationGradient ? 10 : 270)
                    .offset(y: animationGradient ? -140 : 140)
            }
    }
    }
}

#Preview {
    BackgroundView()
}
