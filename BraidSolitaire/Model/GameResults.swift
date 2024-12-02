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
    var name: String
    
    init(time: TimeInterval, moves: Int, name: String){
        self.time = time
        self.moves = moves
        self.name = name
    }
}
