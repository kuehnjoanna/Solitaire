//
//  HomeView.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 31.10.24.
//

import SwiftUI


struct MenuView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    @StateObject private var viewModel = ApiViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                Image("BraidLogo")
                    .resizable()
                    .frame(width: 280, height: 280)
            HStack(spacing: 40){
                NavigationLink(destination: GameView().environmentObject(gameViewModel).environmentObject(viewModel)){
                    ButtonView(text: "Play game")
                }
                NavigationLink(destination: BestScoresView().environmentObject(gameViewModel).environmentObject(viewModel)){
                    ButtonView(text: "Best Scores")
                }
                NavigationLink(destination: InstructionsView()){
                    ButtonView(text: "Instructions")
                }
            }
        }
            .padding()
            
            .background(Image("MenuBackground")
                .resizable()
                .blur(radius: 1)
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }
    }
}

//#Preview {
//    MenuView()
//}
