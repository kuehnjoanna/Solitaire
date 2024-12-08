//
//  DeckView.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 19.11.24.
//

import SwiftUI

struct DeckView: View {
   @EnvironmentObject var gameViewModel: GameViewModel
    @EnvironmentObject  var viewModel: ApiViewModel
    var namespace: Namespace.ID

    var body: some View {
        VStack {
            VStack {
                // Display minutes and seconds
                Text(gameViewModel.timeString(from: (gameViewModel.timePassed)))
                    .font(.title)
                    .foregroundStyle(.white)
                
                // Start/Stop Button
//                Button(action: {
//                    if gameViewModel.isRunning {
//                        gameViewModel.stopTimer()
//                        print(gameViewModel.timePassed)
//                    } else {
//                        gameViewModel.startTimer()
//                        
//                    }
//                }) {
//                    Text(gameViewModel.isRunning ? "Stop" : "Start")
//                        .font(.title)
//                        .padding()
//                        .background(gameViewModel.isRunning ? Color.red : Color.green)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
            }
            .padding()
            ControlButtonsView().environmentObject(gameViewModel)
            
            // Open Deck
            ZStack {
                if gameViewModel.slots[SlotCode.openDeck.rawValue].isEmpty {
                    EmptyCardView(opacity: 0.5, apiImage: viewModel.randomImage, apiImageURL: viewModel.randomImage?.largeImageURL)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    ForEach(gameViewModel.slots[SlotCode.openDeck.rawValue]) { card in
                        CardView(image: card.picture)
                            .matchedGeometryEffect(id: card.id, in: namespace)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    gameViewModel.slotTapped(slotNum: SlotCode.openDeck.rawValue)
                                    gameViewModel.autoCollect()
                                    print("open deck cardtapped \(card.id)")
                                }
                            }
                    }
                }
            }
            
            // Closed Deck
            ZStack {
                if gameViewModel.slots[SlotCode.closedDeck.rawValue].isEmpty {
                    EmptyCardView(opacity: 0.5, apiImage: viewModel.randomImage, apiImageURL: viewModel.randomImage?.largeImageURL)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                gameViewModel.slotTapped(slotNum: SlotCode.closedDeck.rawValue)
                                gameViewModel.autoCollect()
                                print("closed deck cardtapped")
                            }
                        }
                }else {
                    ForEach(gameViewModel.slots[SlotCode.closedDeck.rawValue]) { card in
                        EmptyCardView(opacity: 0.5, apiImage: viewModel.randomImage, apiImageURL: viewModel.randomImage?.largeImageURL)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    gameViewModel.slotTapped(slotNum: SlotCode.closedDeck.rawValue)
                                    gameViewModel.autoCollect()
                                    print("closed deck cardtapped \(card.id)")
                                }
                            }
                    }
                    
                }
            }
        }
       // .frame(width: UIScreen.main.bounds.width * 0.2)
    }
}


//#Preview {
//    DeckView(gameViewModel: GameViewModel(), viewModel: ApiViewModel(), namespace: )
//}
