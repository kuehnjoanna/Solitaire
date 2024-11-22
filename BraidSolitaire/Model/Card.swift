//
//  CardModel.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 31.10.24.
//

import Foundation
struct Card: Identifiable, Hashable, Codable {
    var id = UUID()
    var suit: Suit
    var rank: Int
    var picture: String
}

enum Suit: Codable{
    case Club, Spade, Heart, Diamond
}

