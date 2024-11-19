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
        VStack {
            Button("undo") {
                print(gameViewModel.moveHistory)
                gameViewModel.unmove()
                print(gameViewModel.moveHistory)
            }
            Button("move card") {
                dump(gameViewModel.slots[SlotCode.braid.rawValue])
            }
            Button("shuffle card deck") {
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
