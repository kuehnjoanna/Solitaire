//
//  GameScreen.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 31.10.24.
//

import SwiftUI
struct GameView: View {
    @StateObject var gameViewModel = GameViewModel()
    @Namespace var namespace
    let columns = [
        GridItem(.fixed(40)),
         GridItem(.fixed(40))
     ]
    var body: some View {
        HStack(alignment: .center) {
            VStack{
                LazyVGrid(columns: columns, spacing: 2) {  // Grid with two columns
                    ForEach(gameViewModel.collection.indices, id: \.self) { index in
                        if !gameViewModel.collection[index].isEmpty{
                            CardView(card: gameViewModel.collection[index].last!)
                        } else{
                            RoundedRectangle(cornerRadius: 25)
                                .overlay(
                                    Image("cardBackground")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 70)
                                    
                                )
                                .frame(width: 40, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
            }
            VStack(){
                ZStack{
                ForEach(gameViewModel.braid.indices, id: \.self) { index in
                    let card = gameViewModel.braid[index]
                    CardView(card: card)
                        .visualEffect { @MainActor content, geometryProxy in
                            content
                                .rotationEffect(
                                    Angle(degrees: index % 2 == 0 ? progress(geometryProxy) * -15 : progress(geometryProxy) * 15)
                                )
                                .offset(
                                    x: index % 2 == 0 ? -15 : 15,
                                    y: CGFloat(index) * 15
                                )
                        }
                        .matchedGeometryEffect(id: card.id, in: namespace)
                }
                }.frame( maxHeight: .infinity, alignment: .topLeading)
                    .padding(20)
            }
            VStack{
                LazyVGrid(columns: [GridItem(.fixed(70))], spacing: 2) {  // Grid with two columns
                    ForEach(gameViewModel.edges.indices, id: \.self) { index in
                        if !gameViewModel.edges.isEmpty{
                            CardView(card: gameViewModel.edges[index])
                        } else{
                            RoundedRectangle(cornerRadius: 25)
                                .overlay(
                                    Image("cardBackground")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 70)
                                    
                                )
                                .frame(width: 50, height: 70)
                        }
                    }
                }
            }
            VStack{
                LazyVGrid(columns: columns, spacing: 0) {  // Grid with two columns
                    ForEach(gameViewModel.helpers.indices, id: \.self) { index in
                        if !gameViewModel.helpers.isEmpty{
                            CardView(card: gameViewModel.helpers[index])
                        } else{
                            RoundedRectangle(cornerRadius: 25)
                                .overlay(
                                    Image("cardBackground")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 70)
                                    
                                )
                                .frame(width: 50, height: 70)
                        }
                    }
                }
            }
          
            
                        VStack {
                            Button("check card") {
                                print(gameViewModel.collection)
                            }
                            Button("move card") {
                                print("card moved")
                                gameViewModel.moveCard()
                            }
                            Button("shuffle card deck") {
                                withAnimation(.bouncy) {
                                    gameViewModel.initializeCards()
                                }
                                print(gameViewModel.shuffledDeck.count)
                            }
                            Button("click the deck") {
                                guard let currentCard = gameViewModel.currentCard else { return }
                                gameViewModel.cardTapped(thisCard: currentCard)
                            }
            
                            ZStack {
                                if gameViewModel.movedCards.isEmpty {
                                    RoundedRectangle(cornerRadius: 25)
                                        .overlay(
                                            Image("cardBackground")
                                                .resizable()
                                                .scaledToFill()
                                        )
                                        .frame(width: 40, height: 60)
                                } else {
                                    ForEach(gameViewModel.movedCards) { card in
                                        CardView(card: card)
                                            .matchedGeometryEffect(id: card.id, in: namespace)
                                            .onTapGesture {
                                                withAnimation(.easeInOut) {
                                                    gameViewModel.cardTapped(thisCard: card)
                                                }
                                            }
                                    }
                                }
                            }
                            // Deck of cards
                            ZStack {
                                if gameViewModel.shuffledDeck.isEmpty {
                                    RoundedRectangle(cornerRadius: 25)
                                        .overlay(
                                            Image("cardBackground")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 40, height: 60)
            
                                        )
                                        .frame(width: 40, height: 60)
                                } else {
                                    ForEach(gameViewModel.shuffledDeck) { card in
                                        CardView(card: card)
                                            .matchedGeometryEffect(id: card.id, in: namespace)
                                            .onTapGesture {
                                                withAnimation(.easeInOut) {
                                                    gameViewModel.moveCard()
                                                }
                                            }
                                    }
                                }
                            }
                        }
                            .frame(width: UIScreen.main.bounds.width * 0.3)
        }
    }
}

    
 




#Preview {
    GameView()
}
struct CardView: View {
    var card: Card
    var body: some View{
        RoundedRectangle(cornerRadius: 10)
            .overlay(
                Image(card.picture)
                    .resizable()
                    .scaledToFill()
            )
            .frame(width: 40, height: 60)
    }
}

struct EmptyCardView: View {
    var body: some View{
        RoundedRectangle(cornerRadius: 25)
            .overlay(
                Image("cardBackground")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 150)

            )
            .frame(width: 50, height: 70)
    }
}

