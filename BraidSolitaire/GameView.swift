//
//  GameScreen.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 31.10.24.
//

import SwiftUI
import SwiftData
struct GameView: View {
    
    @EnvironmentObject var gameViewModel: GameViewModel
     @EnvironmentObject  var viewModel: ApiViewModel
    @Namespace var namespace
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        HStack(alignment: .center) {
            // Collections
            CollectionsView( namespace: namespace).environmentObject(gameViewModel).environmentObject(viewModel)
            
            // Braid
            BraidView( namespace: namespace).environmentObject(gameViewModel)
            // Corners
            CornersView(namespace: namespace).environmentObject(gameViewModel).environmentObject(viewModel)
            // Helpers
            HelpersView(namespace: namespace).environmentObject(gameViewModel).environmentObject(viewModel)
            // Open & Closed Decks with Control Buttons
            DeckView(namespace: namespace).environmentObject(gameViewModel).environmentObject(viewModel)
           

        }
        .padding(.bottom, 10)
        .onAppear(){
            gameViewModel.startGamesTimer()
        }
        .onDisappear(){
            gameViewModel.stopTimer()
        }
 
        }
        
//    init(modelContext: ModelContext) {
//        let gameViewModel = GameViewModel(modelContext: modelContext)
//    }
    
    }
    

 




//#Preview {
//    GameView()
//}



