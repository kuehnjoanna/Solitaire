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
    @Published var slots = [[Card]]()
     @Published   var moveHistory = [Int]()
      @Published  var startingRank = 5
    var redeals = 3
    
    @Published var shuffledDeck : [Card] = []
    init(){
        start()
    }
    
    //change this enum for the other one - delete it
            enum slotCode: Int {
            case closedDeck = 0
            case openDeck = 1
            case helpersFirst = 2
            case cornersFirst = 10
            case braid = 14
            case collectionsFirst = 15
            
        }
        func start(){
            
             //var slots = [[Card]]()
            slots = Array(repeating: [], count: 23)
            moveHistory.removeAll()
          //  startingRank = 5
            shuffleCardDeck()
            for _ in 0...22{
               // slots.append([Card]())
                //slots.append([deck2[i]])
                //adding cards to the Helpers slots
                for i in slotCode.helpersFirst.rawValue...(slotCode.cornersFirst.rawValue - 1){
                    addCards(range: 0...0, list: &slots[i], listName: "helpers")
                }
                //adding cards to the corners slots
                for i in slotCode.cornersFirst.rawValue...(slotCode.braid.rawValue - 1){
                    addCards(range: 0...0, list: &slots[i], listName: "corners")
                }
                //adding to the braid slot
                addCards(range: 0...19, list: &slots[slotCode.braid.rawValue], listName: "braid")
                //adding one card to the collection
                addCards(range: 0...0, list: &slots[slotCode.collectionsFirst.rawValue], listName: "collection")
                startingRank = slots[slotCode.collectionsFirst.rawValue].first!.rank
                //adding cards to the deck
           //     slots[slotCode.closedDeck.rawValue] = shuffledDeck
                addCards(range: 0...shuffledDeck.count, list: &slots[slotCode.closedDeck.rawValue], listName: "closed deck")
                dump(slots)
            }

        }
    func shuffleCardDeck(){
        let shuffledCards: [Card] = cardsRepo.doubleDeck.shuffled()
        shuffledDeck = shuffledCards
    }
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
        func move(from source: Int, to target: Int){
            moveHistory.append(source*100 + target)
            transferTheCard(from: source, to: target)
            // if a corner cell is emptied, we need to automatically replace it from braid
            if NSRange(location: slotCode.cornersFirst.rawValue, length: 4).contains(source) {
                // yep... our suspician was correct, it WAS a corner cell. Now it's empty...
                // the source of the previous move is our new target, we fill it from braid, if braid is not empty
                if slots[slotCode.braid.rawValue].isEmpty {
                    //braid is depleted, we will leave the corner empty
                    return
                }
                // braid still has at least 1 card, we put it to the just emptied corner cell, which is "source" of the last move
                move(from: slotCode.braid.rawValue, to: source)
            }
        }
        func unmove(){
            if moveHistory.isEmpty {return}
            let moveCode = moveHistory.removeLast()
            print(moveCode)
            if moveCode == -1 {
                // Special move to redeal, we give back the right to redeal
                redeals += 1
                // we reverse the closed deck and open it
                slots[slotCode.openDeck.rawValue] = slots[slotCode.closedDeck.rawValue].reversed()
                slots[slotCode.closedDeck.rawValue].removeAll()
                return
            }
            transferTheCard(from: moveCode%100, to: moveCode/100)
            
            // wait! before we leave... if the move was done from braid to the corners it means it was an automated move
            // taking it back would leave the corner empty, we need to take one more back so the corner card is not played yet
            if moveCode/100 == slotCode.braid.rawValue
                && NSRange(location: slotCode.cornersFirst.rawValue, length: 4).contains(moveCode%100){
                // source is braid, target is one of corner slots, we take one more move back
                unmove()
            }
        }
        func transferTheCard(from: Int, to: Int){
            // Animations
            let card = slots[from].removeLast() //cant remove last element from an empty collection
            slots[to].append(card)
        }
    /// this is called if the card is not of starting rank\
        func findFirstEmptyCollectionSlot() -> Int{
          //  var emptySlot = 0
            for i in 0...7{
                if slots[ slotCode.collectionsFirst.rawValue + i].isEmpty{
                    return slotCode.collectionsFirst.rawValue + i
                }
            }
            fatalError("There are more than 8 starting rank cards")
        }
        func findFirstCollectionSlotThatCanAccept(card: Card) -> Int?{
            for i in 0...7{
                let index = i + slotCode.collectionsFirst.rawValue
                // if we reached an empty slot, that means we couldn't find anything suitable
                if slots[index].isEmpty {return nil}
                
                // if the slot is already full, we move on and check the next
                if slots[index].count == 13 {continue}
                
                // if the suits don't match, we move on
                if slots[index].last!.suit != card.suit {continue}
                
                // what do we know here? current index we are checking, is not empty, not full, same rank
                if canFollow(slots[index].last!.rank, card.rank){return index}
                
                // not a number that can follow we continue
                continue // not necessary since it's already the end of for loop :)
            }
            // we are out of the loop and we haven't returned yet, it means we couldn't find a suitable slot
            return nil
        }
    func canFollow(_ first: Int, _ next: Int)->Bool{
        // Ace is allowed after King
        if first == 13 && next == 1 {return true}
        if first + 1 == next {return true}
        return false
    }
    func slotTapped(slotNum: Int){
        
            if slotNum == slotCode.closedDeck.rawValue{
            // if there's a card in closedDeck, we open and move it
            if slots[slotNum].count > 0 {
                move(from: slotCode.closedDeck.rawValue, to: slotCode.openDeck.rawValue)
                return
            }

            // No cards left in closed deck, time to put the open ones back,
            // But if we have no redeals left, we do nothing
            if redeals == 0 {return}
            
            // we have redeals, we just lost one
            redeals -= 1
            
            // now we take all card form the open deck, reverse them and move them to closed deck
            slots[slotNum] = slots[slotCode.openDeck.rawValue].reversed()
            
            // we empty the open deck
            slots[slotCode.openDeck.rawValue] = []
            
            // we add this move as a special move to our moveHistory
            moveHistory.append(-1) // we can name it as redealMove if it gets complicated, but since we have no other special moves, -1 should work
            
            return
        }
        // we don't do anything if an empty slot is tapped
        if slots[slotNum].isEmpty {return}
        
        // we don't do anything if a collection slot is tapped
        // works if the collections are the last on slots
        if slotNum >= slotCode.collectionsFirst.rawValue {return}
        
        // We already eliminited collections to come here, anything else can be collected
        // We also know that slot is not empty
        // Let's check if it's the startingRank
        let card = slots[slotNum].last!
        if card.rank == startingRank {
            // at least one of the collection slots must be empty
            if let emptySlot = findFirstEmptySlot(starting: slotCode.collectionsFirst.rawValue, count: 8){
                move(from: slotNum, to: emptySlot)
                return
            }
            
            fatalError("8 collection slots are full but we still found another starting rank card")
        }
        
        // let's check if any collection slots can receive our card
        if let suitableCollectionSlot = findFirstCollectionSlotThatCanAccept(card: card) {
            // Only if it found a suitable place
            move(from: slotNum, to: suitableCollectionSlot)
            return
        }
        
        // So far... we know there's a card in the slot,
        // and since we come this far, it means it can't be collected.
        // if it's from the open deck, it can be put in an empty helper slot, and if the braid is depleted, in can even be put in a corner slot
        if slotNum == slotCode.openDeck.rawValue{
            // find an empty helper
            if let emptyHelper = findFirstEmptySlot(starting: slotCode.helpersFirst.rawValue, count: 8){
                move(from: slotNum, to: emptyHelper)
                return
            }
            // no empty helper was found, if braid has a card, we are done
            if slots[slotCode.braid.rawValue].count > 0 {
                return
            }
            
            // braid is depleted, we can use corners if there's an empty one
            if let emptyCorner = findFirstEmptySlot(starting: slotCode.cornersFirst.rawValue, count: 4){
                move(from: slotNum, to: emptyCorner)
                return
            }
            
        }
        
        // I think that's it
        return
    }
    
    func findFirstEmptySlot(starting: Int, count: Int)->Int?{
        for i in 0...(count-1){
            if slots[starting + i].isEmpty{
                return starting + i
            }
        }
        return nil
    }
    func isGameOver()->Bool{
        var fullCollectionSlots = 0
        for i in 0...7{
            if slots[slotCode.collectionsFirst.rawValue + i].count == 13 {
                fullCollectionSlots += 1
            }
        }
        if fullCollectionSlots == 8 {
            return true
        }
        return false
    }
    
    func autoCollect(){
        // if deck and braid is empty, everything is accessible
        if slots[slotCode.braid.rawValue].isEmpty
            && slots[slotCode.openDeck.rawValue].isEmpty
            && slots[slotCode.closedDeck.rawValue].isEmpty {
            
            while(!isGameOver()){
                //just tap everything like crazy, no need to do any calculations
                for i in 0..<slotCode.collectionsFirst.rawValue { // if collections are last
                    slotTapped(slotNum: i)
                }
            }
        }
    }
    
    func undoAll(){
        while(moveHistory.count > 0){
            unmove()
        }
    }

}
