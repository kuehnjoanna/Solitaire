//
//  GameScreen.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 31.10.24.
//

import SwiftUI

struct GameScreen: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("click mich"){
            print(CardsRepository().cardDeck)
        }
    }
}

#Preview {
    GameScreen()
}
