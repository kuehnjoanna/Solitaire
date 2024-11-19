//
//  utils.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 12.11.24.
//

import Foundation
import SwiftUI

    func minX(_ proxy: GeometryProxy) -> CGFloat {
        let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
        return minX < 0 ? 0 : -minX
    }

    func progress(_ proxy: GeometryProxy, limit: CGFloat = 2) -> CGFloat{
        let maxX = proxy.frame(in: .scrollView(axis: .horizontal)).maxX
        let width = proxy.bounds(of: .scrollView(axis: .horizontal))?.width ?? 0
        //converting into progress
        let progress = (maxX / width) - 1.0
        let cappedProgress = min(progress, limit)
        
        return cappedProgress
    }
    
    func excessMinX(_ proxy: GeometryProxy, offset: CGFloat = 10) -> CGFloat {
        let progress = progress(proxy)
        
        return progress * offset
    }
    @MainActor
    func rotation(_ proxy: GeometryProxy, rotation: CGFloat = 5) -> Angle {
        let progress = progress(proxy)
        
        return .init(degrees: progress * rotation)
    }
    func scale (_ proxy: GeometryProxy, scale: CGFloat = 0.1) -> CGFloat{
        let progress = progress(proxy, limit: 4)
        return 1 - (progress * scale)
    }
///////////////////////////////////////////////////////////////////////////////////

// var slots = [[Card]]()
//    var moveHistory = [Int]()
//    var startingRank = 5
//var deck2 = CardsRepository().doubleDeck.shuffled()
////    enum slotCode: Int {
////        case closedDeck = 0
////        case openDeck = 1
////        case helpersFirst = 2
////        case cornersFirst = 10
////        case braid = 14
////        case collectionsFirst = 15
////        
////    }
//    func start(){
//        for i in 0...22{
//            //slots.append([Card]())
//            slots.append([deck2[i]])
//        }
//    }
//
//    func move(from source: Int, to target: Int){
//        moveHistory.append(source*100 + target)
//        transferTheCard(from: source, to: target)
//    }
//    func unmove(){
//        let moveCode = moveHistory.removeLast()
//        transferTheCard(from: moveCode%100, to: moveCode/100)
//    }
//    func transferTheCard(from: Int, to: Int){
//        // Animations
//        let card = slots[from].removeLast() //cant remove last element from an empty collection
//        slots[to].append(card)
//    }
//    func findFirstEmptyCollectionSlot() -> Int{
//      //  var emptySlot = 0
//        for i in 0...7{
//            if slots[ slotCode.collectionsFirst.rawValue + i].isEmpty{
//                return slotCode.collectionsFirst.rawValue + i
//            }
//        }
//        fatalError("There are more than 8 starting rank cards")
//    }
//    func findFirstCollectionSlotThatCanAccept(card: Card) -> Int?{
//        for i in 0...7{
//            let collectionCard = slots[slotCode.collectionsFirst.rawValue + i].last
//            if collectionCard != nil{
//            if startingRank == 13 && collectionCard?.rank == 1 {
//                 return slotCode.collectionsFirst.rawValue + i
//            }
//            if startingRank == collectionCard!.rank - 1{
//                return slotCode.collectionsFirst.rawValue + i
//            }
//        }
//        }
//
//        return 20
//    }
//    func slotTapped(slotNum: Int){
//        // we don't do anything if an empty slot is tapped
//        if slots[slotNum].isEmpty {return}
//        
//        // we don't do anything if a collection slot is tapped
//        // works if the collections are the last on slots
//        if slotNum >= slotCode.collectionsFirst.rawValue {return}
//        
//        if slotNum == slotCode.closedDeck.rawValue{
//            if slots[slotNum].isEmpty{
//                slots[slotNum] = slots[1]
//                slots[1] = []
//            } else {
//                move(from: 0, to: 1)
//            }
//        }
//        if slotNum > 0 {
//            // We already eliminited collections to come here, anything can be collected
//            // We also know that slot is not empty
//            // Let's check if it's the startingRank
//            let card = slots[slotNum].last!
//            if card.rank == startingRank {
//                // at least one of the collection slots must be empty
//                move(from: slotNum * 100 + findFirstEmptyCollectionSlot(), to: findFirstEmptyCollectionSlot())
//                return
//            }
//            
//            if let suitableCollectionSlot = findFirstCollectionSlotThatCanAccept(card: card) {
//                // Only if it found a suitable place
//                move(from: slotNum, to: suitableCollectionSlot)
//                return
//            }
//        }
//        
//        // So far... we know there's a card in the slot,
//        // and since we come this far, it means it can't be collected.
//}
