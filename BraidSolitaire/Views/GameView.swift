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
    @State var name: String = ""
    @State var errorMessage: String = ""
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
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
        .sheet(isPresented: $gameViewModel.isSheetPresented){
            VStack {
                Text("What is your name?")
                    .font(.title)
                    .padding()
                TextField("name", text: $name)
                Text(errorMessage)
                HStack{
                Button(action: {
                    if name.isEmpty{
                        errorMessage = "Name can't be empty!"
                    } else {
                        gameViewModel.saveResult(name: name)
                        dismiss() // Dismiss the sheet
                    }
                }) {
                    Text("Save")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                    
                    Button("close"){
                        dismiss()
                    }
            }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 30)
        .background{
            BackgroundView()
        }
        .ignoresSafeArea()
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



