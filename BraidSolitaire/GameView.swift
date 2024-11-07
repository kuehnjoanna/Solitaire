//
//  GameScreen.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 31.10.24.
//

import SwiftUI

struct GameScreen: View {
@StateObject var gameViewModel = GameViewModel()
    
    @State private var selectedItem: Card? = nil
    @State private var animationCompleted = false
    @State private var isClicked: Bool = false
    var body: some View {
        VStack{
            HStack{
                Button("check card"){
                    //  gameViewModel.moveCard()
                    print(gameViewModel.collection)
                }
                Button("move card"){
                    print("card moved")
                      gameViewModel.moveCard()
                }
                //
            }
          
            HStack{
                Button("shuffle card deck"){
                    //gameViewModel.shuffleCardDeck()
                    gameViewModel.initializeCards()
                    
                    print(gameViewModel.shuffledDeck.count)
                }
                Button("click the deck"){
                    guard let currentCard = gameViewModel.currentCard else { return}
                    gameViewModel.cardTapped(thisCard: currentCard)
          
                }
            }
        }
    }
}

#Preview {
    GameScreen()
}
