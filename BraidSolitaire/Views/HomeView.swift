//
//  HomeView.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 31.10.24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
    @StateObject private var viewModel = ApiViewModel()
    
    var body: some View {
        NavigationStack{
            NavigationLink(destination: GameView().environmentObject(gameViewModel).environmentObject(viewModel)){
                Text("game view")
        }
            NavigationLink(destination: WelcomeView().environmentObject(gameViewModel).environmentObject(viewModel)){
                Text("Best Scores")
        }
        }
    }
}

#Preview {
    HomeView()
}
