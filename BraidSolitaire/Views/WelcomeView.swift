//
//  WelcomeView.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 31.10.24.
//

import SwiftUI


struct WelcomeView: View {
    @StateObject var gameViewModel = GameViewModel()
     @StateObject var viewModel = ApiViewModel()
     @Namespace var namespace
     
     var body: some View {
         HStack(alignment: .center) {
             // Collections
             CollectionsView( namespace: namespace).environmentObject(gameViewModel).environmentObject(viewModel)
             
             // Braid
             BraidView(namespace: namespace).environmentObject(gameViewModel)
             
             // Corners
             CornersView(namespace: namespace).environmentObject(gameViewModel).environmentObject(viewModel)
             
             // Helpers
             HelpersView(namespace: namespace).environmentObject(gameViewModel).environmentObject(viewModel)
             
             // Open & Closed Decks with Control Buttons
             DeckView(namespace: namespace).environmentObject(gameViewModel).environmentObject(viewModel)
         }
     }
    
}


#Preview {
    WelcomeView()
}
