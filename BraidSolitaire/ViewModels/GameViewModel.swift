//
//  GameViewModel.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 31.10.24.
//

import Foundation
class GameViewModel: ObservableObject{
    private var cardsRepo = CardsRepository()

    var movedCards: [CardModel] = []
    var collection: [CardModel] = []
    var braid: [CardModel] = []
    var edges: [CardModel] = []
    var helpers: [CardModel] = []
    var shuffledDeck : [CardModel] = []
    
    
    //function for shuffling card deck
    func shuffleCardDeck(){
        let shuffledCards: [CardModel] = cardsRepo.doubleDeck.shuffled()
//        let shuffledCards: [CardModel] = [
//            CardModel(suit: .Spade, rank: 13, picture: "SpadeKing"),
//            CardModel(suit: .Club, rank: 1, picture: "ClubAce"),
//            CardModel(suit: .Heart, rank: 13, picture: "HeartKing"),
//            CardModel(suit: .Diamond, rank: 1, picture: "DiamondAce"),
//        ]
        shuffledDeck = shuffledCards
    }
    
    
    //change name for something more accurate
    func initializeCards(){
        
         add(range: 1...20, list: &braid, listName: "braid")
        add(range: 1...4, list: &edges, listName: "edges")
        add(range: 1...8, list: &helpers, listName: "helpers")
        //
        
    }
    
    func add(range: ClosedRange<Int>, list: inout [CardModel], listName: String){
        for i in range{
            guard let cardFromDeck = shuffledDeck.last else {
                return print("deck is empty!")
            }
            shuffledDeck.removeAll{ $0 == cardFromDeck }
            list.append(cardFromDeck)
            print(shuffledDeck.count)
            print("CARD \(i): \(cardFromDeck)")
        }
        print("\(listName): \(list)")
    }
    
    //function for moving card from deck to the moved ones
    func moveCard(){
        guard let lastCard = shuffledDeck.last else {
            return print("deck is empty!")
        }
        shuffledDeck.removeAll{ $0 == lastCard }
        movedCards.append(lastCard)
        print(shuffledDeck.count)
        print(movedCards)
    }
    
    
    
}
