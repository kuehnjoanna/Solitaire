//
//  GameScreen.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 31.10.24.
//

import SwiftUI

struct GameScreen: View {
@StateObject var gameViewModel = GameViewModel()
    
    @State private var selectedItem: CardModel? = nil
    @State private var animationCompleted = false
    @State private var isClicked: Bool = false
    var body: some View {
        VStack{
            HStack{
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Button("move card"){
                    print("lol")
                    //  gameViewModel.moveCard()
                    gameViewModel.initializeCards()
                }
                //
            }
            HStack{
                Button("shuffle card deck"){
                    gameViewModel.shuffleCardDeck()
                    print(gameViewModel.shuffledDeck.count)
                }
                Button("click the deck"){
                    print(gameViewModel.shuffledDeck)
                    print(gameViewModel.shuffledDeck)
                }
            }
            
                VStack{
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.gray)
                        .frame(width: 100, height: 100)
                       // .zIndex(selectedItem == item ? 1 : 0)
                       // .matchedGeometryEffect(id: item.id, in: namespace)  // Unique identifier for animation
                        .onTapGesture {
                            withAnimation(.easeInOut) {  // Set animation duration
                          //      selectedItem = item  // Set selected item
                                isClicked = true
                                animationCompleted.toggle()  // Trigger animation completion toggle
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                // Move item to the second stack
                                if let selectedItem = selectedItem {
                                    self.selectedItem = nil
                                    isClicked = false
                                }
                            }
                            
                        }
                }
            VStack{
                
            }
        }
    }
}

#Preview {
    GameScreen()
}
