//
//  GameViewModel.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 31.10.24.
//

import Foundation
import SwiftUI
class GameViewModel: ObservableObject{
    private var cardsRepo = CardsRepository()
    
    var movedCards: [Card] = []
    var collection: [[Card]] = [[], [], [], [], [], [], [], []]
    var braid: [Card] = []
    var edges: [Card] = []
    var helpers: [Card] = []
    var shuffledDeck : [Card] = []
    var currentCard: Card? = nil
    var startingRank: Int = 0
    
    
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
        collection.append([first])
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
    }
    
    func moveIfCollectionAccepts( collectionIndex i: Int, thisCard: Card )->Bool{
            guard let currentCard = currentCard else { return false}
            if collection[i].isEmpty{
                if thisCard.rank != startingRank{ // if ranks don't match, move on
                    return false
                }
                move(currentcard: currentCard, collectionIndex: i)
                return true
            }
            if collection[i].last!.suit != thisCard.suit{ // if suits don't mach, move on
                return false
            }
            if !canFollow(lastRank: collection[i].last!.rank, currentRank: thisCard.rank){
                return false // if can't follow move on
            }
            // passed all tests
            move(currentcard: currentCard, collectionIndex: i)
            return true
        }
    func move(currentcard: Card, collectionIndex: Int){
            movedCards.removeLast()
            collection[collectionIndex].append(currentcard)
            print("card found! collection: \(collection)")
            currentCard = movedCards.last
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
