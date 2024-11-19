//
//  GameScreen.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 31.10.24.
//

import SwiftUI
struct GameView: View {
    @StateObject var gameViewModel = GameViewModel()
    
    @StateObject private var viewModel = ApiViewModel()
    @Namespace var namespace
    let columns = [
        GridItem(.fixed(40)),
        GridItem(.fixed(40))
    ]
    var body: some View {
        HStack(alignment: .center) {
            // COLLECTIONS
            VStack{
                LazyVGrid(columns: columns, spacing: 2) {  // Grid with two columns
                    ForEach(SlotCode.collectionsFirst.rawValue...22, id: \.self){ index in
                        if !gameViewModel.slots[index].isEmpty{
                            RoundedRectangle(cornerRadius: 10)
                                .overlay(
                                    Image(gameViewModel.slots[index].last!.picture)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 40, height: 60)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                )
                                .frame(width: 40, height: 60)
                                .matchedGeometryEffect(id: gameViewModel.slots[index].last!.id, in: namespace)
                            
                        } else{
                            EmptyCardView(opacity: 0.5, apiImage: viewModel.randomImage, apiImageURL: viewModel.randomImage?.largeImageURL)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
                    }
                    
                }
            }
            // BRAID
            VStack(){
                ZStack{
                    
                    //schreiben tap fur der letzte
                    ForEach(gameViewModel.slots[SlotCode.braid.rawValue].indices, id: \.self) { index in
                        let isLastCard = index == gameViewModel.slots[SlotCode.braid.rawValue].indices.last
                        let cardPicture = gameViewModel.slots[SlotCode.braid.rawValue][index].picture
                    CardView(image: cardPicture)
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
                        .matchedGeometryEffect(id: gameViewModel.slots[SlotCode.braid.rawValue][index].id, in: namespace)
                        .onTapGesture {
                                       if isLastCard {
                                           // Perform your desired action here
                                           gameViewModel.slotTapped(slotNum: 14)
                                       }
                                   }
                }
                }.frame( maxHeight: .infinity, alignment: .topLeading)
                    .padding(20)
            }
                // CORNERS
                VStack{
                    LazyVGrid(columns: [GridItem(.fixed(70))], spacing: 2) {
                        ForEach(SlotCode.cornersFirst.rawValue...(SlotCode.braid.rawValue - 1), id: \.self){index in
                            if !gameViewModel.slots[index].isEmpty{
                                CardView(image: gameViewModel.slots[index].last!.picture)
                                    .matchedGeometryEffect(id: gameViewModel.slots[index].last!.id, in: namespace)
                                    .onTapGesture {
                                        withAnimation(.easeInOut) {
                                            gameViewModel.slotTapped(slotNum: index)//
                                            gameViewModel.autoCollect()
                                            print("cardtapped  id\(index)")
                                        }
                                    }
                                
                            } else{
                                EmptyCardView(opacity: 0.5, apiImage: viewModel.randomImage, apiImageURL: viewModel.randomImage?.largeImageURL)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            
                        }
                    }
                }
                //HELPERS
                VStack{
                    LazyVGrid(columns: columns, spacing: 0) {  // Grid with two columns
                        ForEach(SlotCode.helpersFirst.rawValue...(SlotCode.cornersFirst.rawValue - 1), id: \.self){index in
                            if !gameViewModel.slots[index].isEmpty{
                                CardView(image: gameViewModel.slots[index].last!.picture)
                                    .matchedGeometryEffect(id: gameViewModel.slots[index].last!.id, in: namespace)
                                    .onTapGesture {
                                        withAnimation(.easeInOut) {
                                            gameViewModel.slotTapped(slotNum: index)//
                                            gameViewModel.autoCollect()
                                            print("cardtapped  id\(index)")
                                        }
                                    }
                                
                                
                            } else{
                                EmptyCardView(opacity: 0.5, apiImage: viewModel.randomImage, apiImageURL: viewModel.randomImage?.largeImageURL)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            
                        }
                    }
                }
                
                //OPEN & CLOSED DECK
                VStack {
                    Button("undo") {
                        print(gameViewModel.moveHistory)
                        gameViewModel.unmove()
                        print(gameViewModel.moveHistory)
                    }
                    Button("move card") {
                        dump(gameViewModel.slots[SlotCode.braid.rawValue])
                        //       gameViewModel.moveCard()
                    }
                    Button("shuffle card deck") {
                        withAnimation(.bouncy) {
                            //                gameViewModel.initializeCards()
                        }
                        //           print(gameViewModel.shuffledDeck.count)
                    }
                    Button("click the deck") {
                        //                                guard let currentCard = gameViewModel.currentCard else { return }
                        //                                gameViewModel.cardTapped(thisCard: currentCard)
                    }
                    // OPEN DECK
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
                                            print("open deck cardtapped")
                                        }
                                    }
                            }
                        }
                    }
                    // CLOSED DECK
                    ZStack {
                        if gameViewModel.slots[SlotCode.closedDeck.rawValue].isEmpty{
                            //if deck is empty
                            EmptyCardView(opacity: 0.5, apiImage: viewModel.randomImage, apiImageURL: viewModel.randomImage?.largeImageURL)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        gameViewModel.slotTapped(slotNum: SlotCode.closedDeck.rawValue)
                                        gameViewModel.autoCollect()
                                        print("closed deck cardtapped")
                                    }
                                }
                        } else {
                            ForEach(gameViewModel.slots[SlotCode.closedDeck.rawValue]) { card in
                                EmptyCardView(opacity: 0.0, apiImage: viewModel.randomImage, apiImageURL: viewModel.randomImage?.largeImageURL)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .onTapGesture {
                                        withAnimation(.easeInOut) {
                                            gameViewModel.slotTapped(slotNum: SlotCode.closedDeck.rawValue)
                                            gameViewModel.autoCollect()
                                            print("closed deck cardtapped")
                                        }
                                    }
                            }
                            
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.3)
                .onAppear {
                    // gameViewModel.start()
                }
            }
        }
        
        
    }
    

 




#Preview {
    GameView()
}



