//
//  ControlsButtonView.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 19.11.24.
//

import SwiftUI

struct ControlButtonsView: View {
    @EnvironmentObject    var gameViewModel: GameViewModel
    
    var body: some View {
       HStack {
            Button("undo") {
                print(gameViewModel.moveHistory)
                gameViewModel.unmove()
                print(gameViewModel.moveHistory)
            }
            Button("move") {
                dump(gameViewModel.slots[SlotCode.braid.rawValue])
            }
            Button("deck") {
                withAnimation(.bouncy) {
                    // gameViewModel.initializeCards()
                }
            }
        }
    }
}

//
//#Preview {
//    ControlButtonsView(gameViewModel: GameViewModel())
//}