//
//  CardModel.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 31.10.24.
//

import Foundation
struct CardModel: Identifiable, Hashable {
    var id = UUID()
    var suit: Suit
    var rank: Int
    var picture: String
}

enum Suit{
    case Club, Spade, Heart, Diamond
}

