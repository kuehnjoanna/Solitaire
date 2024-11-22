//
//  GameResults.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 21.11.24.
//

import Foundation
import SwiftData
@Model
class GameResults: Identifiable {
    let id: String = UUID().uuidString
    let time: TimeInterval
    let moves: Int
    
    init(time: TimeInterval, moves: Int){
        self.time = time
        self.moves = moves
    }
}
