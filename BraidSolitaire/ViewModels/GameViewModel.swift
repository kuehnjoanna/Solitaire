//
//  GameViewModel.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 31.10.24.
//
//should we call move function movetoacollection?
import Foundation
import SwiftUI

class GameViewModel: ObservableObject{
    private var cardsRepo = CardsRepository()
    
    @Published var movedCards: [Card] = []
    @Published var collection: [[Card]] = [[], [], [], [], [], [], [], []]
    @Published var braid: [Card] = []
    @Published var edges: [Card] = []
    @Published var helpers: [Card] = []
    @Published var shuffledDeck : [Card] = []
    @Published var currentCard: Card? = nil
    var startingRank: Int = 0
    init(){
        initializeCards()
    }
    
    //command + choose section = fold
    ////////////////////////////////////////////INITIALIZING
    //change name for something more accurate
    func initializeCards(){
        //making sure all the lists are empty(in case of previous games)
        movedCards = []
        collection = [[],[],[],[],[],[],[],[]]
        braid = []
        edges = []
        helpers = []
        currentCard = nil
        
        //setting and shuffling new card decks
        shuffleCardDeck()
        
        //initializing game by adding right cards in the beginning  of the game
        addCards(range: 1...20, list: &braid, listName: "braid")
        addCards(range: 1...4, list: &edges, listName: "edges")
        addCards(range: 1...8, list: &helpers, listName: "helpers")
        //
        startCollection()
    }
    
    // getting edges filled from braid
    
    func fillTheEdges(){
        while(edges.count < 4){
            if braid.count == 0 {
                return
            }
            edges.append(braid.removeLast())
            print(braid.count)
        }
    }
    
    //


    //function for shuffling card deck
    func shuffleCardDeck(){
        let shuffledCards: [Card] = cardsRepo.doubleDeck.shuffled()
        shuffledDeck = shuffledCards
    }
    //function for intiilizing
    func addCards(range: ClosedRange<Int>, list: inout [Card], listName: String){
        for _ in range{
            guard let cardFromDeck = shuffledDeck.last else {
                return print("deck is empty!")
            }
            shuffledDeck.removeAll{ $0 == cardFromDeck }
            list.append(cardFromDeck)
            print(shuffledDeck.count)
        }
        print("\(listName): \(list.count)")
    }
    
    //
    func startCollection(){
        guard let first = shuffledDeck.last else {
            return print("no starting card!")
        }
        shuffledDeck.removeLast()
        //    print("first: \(first), remove last: \(shuffledDeck)")
        collection[1].append(contentsOf: [first])
        print("COLLECTION \(collection)")
        startingRank = first.rank
    }
    
    ///////////////////////////////////////////////////
    
    //function for moving card from deck to the moved ones
    func moveCard(){
        guard let lastCard = shuffledDeck.last else {
            return print("deck is empty! deck: \(shuffledDeck)")
            
        }
        movedCards.append(shuffledDeck.removeLast())
        shuffledDeck.removeLast()// error handling needed
        print(shuffledDeck.count)
        //  print(movedCards)
        currentCard = lastCard
        //on movedc card clicked
        cardTapped(thisCard: lastCard)
    }
    ///why di we have to do it as separate function and not in the movecard
    func cardTapped( thisCard: Card ) {
           for i in 0...7{
               let success = moveIfCollectionAccepts(collectionIndex: i, thisCard: thisCard )
               if (success) {
                    return // already moved the card, don't check other indices
               }
           }
//        if edges.count < 4{
//            guard let lastCard = movedCards.last else {
//                return print("deck is empty! deck: \(movedCards)")
//            }
//            edges.append(movedCards.removeLast())
//            print(movedCards.count)
//        }
//        if helpers.count < 8{
//            guard let lastCard = movedCards.last else {
//                return print("deck is empty! deck: \(movedCards)")
//            }
//            helpers.append(movedCards.removeLast())
//            print(movedCards.count)
//        }
    }
    
    func moveIfCollectionAccepts( collectionIndex i: Int, thisCard: Card )->Bool{
            guard let currentCard = currentCard else { return false}
            if collection[i].isEmpty{
                if thisCard.rank != startingRank{ // if ranks don't match, move on
                    return false
                }
                moveCurrentCard( collectionIndex: i)
                return true
            }
            if collection[i].last!.suit != thisCard.suit{ // if suits don't mach, move on
                return false
            }
            if !canFollow(lastRank: collection[i].last!.rank, currentRank: thisCard.rank){
                return false // if can't follow move on
            }
            // passed all tests
            moveCurrentCard( collectionIndex: i)
            return true
        }
    func moveCurrentCard( collectionIndex: Int){
            guard let currentCard = currentCard else { return}
            movedCards.removeLast()
            collection[collectionIndex].append(currentCard)
            print("card found! collection: \(collection)")
            self.currentCard = movedCards.last
        }
    func canFollow(lastRank: Int, currentRank: Int)-> Bool{
            if lastRank == 13 && currentRank == 1 {
                return true
            }
            if lastRank == currentRank - 1{
                return true
            } // else is not necessary here, we said return in the previous if
            
            // conditions not met, can't follow
            return false
            
        }
}
