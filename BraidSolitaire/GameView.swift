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
            VStack{
                LazyVGrid(columns: columns, spacing: 2) {  // Grid with two columns
                    
                    ForEach(slotCode.collectionsFirst.rawValue...22, id: \.self){ index in
                        if !gameViewModel.slots[index].isEmpty{
                            CardView(cardPicture: gameViewModel.slots[index].last!.picture)
                            
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
                    
                    //schreiben tap fur der letzte
                    ForEach(gameViewModel.slots[slotCode.braid.rawValue].indices, id: \.self) { index in
                        let isLastCard = index == gameViewModel.slots[slotCode.braid.rawValue].indices.last
                        let cardPicture = gameViewModel.slots[slotCode.braid.rawValue][index].picture
                    CardView(cardPicture: cardPicture)
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
                        .matchedGeometryEffect(id: gameViewModel.slots[slotCode.braid.rawValue][index].id, in: namespace)
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
            VStack{
                LazyVGrid(columns: [GridItem(.fixed(70))], spacing: 2) {  // Grid with two columns
                    
                    ForEach(slotCode.cornersFirst.rawValue...(slotCode.braid.rawValue - 1), id: \.self){index in
                        if !gameViewModel.slots[index].isEmpty{
                            CardView(cardPicture: gameViewModel.slots[index].last!.picture)
                                .matchedGeometryEffect(id: gameViewModel.slots[index].last!.id, in: namespace)
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        gameViewModel.slotTapped(slotNum: index)//
                                        print("cardtapped  id\(index)")
                                    }
                                }
                            
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
            VStack{
                
                LazyVGrid(columns: columns, spacing: 0) {  // Grid with two columns
                    
                    ForEach(slotCode.helpersFirst.rawValue...(slotCode.cornersFirst.rawValue - 1), id: \.self){index in
                        if !gameViewModel.slots[index].isEmpty{
                            CardView(cardPicture: gameViewModel.slots[index].last!.picture)
                                .matchedGeometryEffect(id: gameViewModel.slots[index].last!.id, in: namespace)
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        gameViewModel.slotTapped(slotNum: index)//
                                        print("cardtapped  id\(index)")
                                    }
                                }
                            
                            
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
          
            
                        VStack {
                            Button("undo") {
                                gameViewModel.unmove()
                        //        print(gameViewModel.collection)
                            }
                            Button("move card") {
                                print("card moved")
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
            
                            ZStack {
                                if gameViewModel.slots[slotCode.openDeck.rawValue].isEmpty {
                                    RoundedRectangle(cornerRadius: 25)
                                        .overlay(
                                            Image("cardBackground")
                                                .resizable()
                                                .scaledToFill()
                                        )
                                        .frame(width: 40, height: 60)
                                } else {
                                    ForEach(gameViewModel.slots[slotCode.openDeck.rawValue]) { card in
                                        CardView(cardPicture: card.picture)
                                            .matchedGeometryEffect(id: card.id, in: namespace)
                                            .onTapGesture {
                                                withAnimation(.easeInOut) {
                                                    gameViewModel.slotTapped(slotNum: 1)
                                                    print("cardtapped")
                                                }
                                            }
                                    }
                                }
                            }
                            // Deck of cards
                            ZStack {
                                if gameViewModel.slots[slotCode.closedDeck.rawValue] .isEmpty {
                                    //if deck is empty
                                    RoundedRectangle(cornerRadius: 10)
                                        .overlay(
                              //change for sth better
                                            Image("cardBackground")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .opacity(0.5)
                                                        .frame(width: 40, height: 60)
                                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                            
                                        )
                                        .frame(width: 40, height: 60)
                                } else {
                                    //if deck is not empty
                                    ForEach(gameViewModel.slots[slotCode.closedDeck.rawValue]) { card in
                                        RoundedRectangle(cornerRadius: 10)
                                            .overlay(
                                                Group {
                                                    if viewModel.randomImage != nil,
                                                       let imageURLString = viewModel.randomImage?.largeImageURL,
                                                       let imageURL = URL(string: imageURLString) {
                                                        
                                                        AsyncImage(url: imageURL) { image in
                                                            image
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fill)
                                                                .frame(width: 40, height: 60)
                                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                        } placeholder: {
                                                            ProgressView()
                                                        }
                                                        
                                                    } else {
                                                        // Fallback image or background if URL is invalid or array is empty
                                                        Image("cardBackground")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(width: 40, height: 60)
                                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                                    }
                                                }
                                            )
                                            .frame(width: 40, height: 60)
                                            .matchedGeometryEffect(id: card.id, in: namespace)
                                            .onTapGesture {
                                                withAnimation(.easeInOut) {
                                                    gameViewModel.slotTapped(slotNum: 0)
                                                    print("cardtapped")
                                                }
                                            }
                                    }
                                    
                                }
                            }
                        }
                            .frame(width: UIScreen.main.bounds.width * 0.3)
                            .onAppear {
                                start()
                            }
        }
    }

    
}

    
 




#Preview {
    GameView()
}
struct CardView: View {
    var cardPicture: String
    var body: some View{
        RoundedRectangle(cornerRadius: 10)
            .overlay(
                Image(cardPicture)
                    .resizable()
                    .scaledToFill()
            )
            .frame(width: 40, height: 60)
    }
}



