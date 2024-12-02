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
         
            Button("restart") {
                dump(gameViewModel.start())
            }
            Button("deck") {
                withAnimation(.bouncy) {
                    // gameViewModel.initializeCards()
                }
            }
            Button("undo") {
               print(gameViewModel.moveHistory)
               gameViewModel.unmove()
               print(gameViewModel.moveHistory)
            }
        }
    }
}

//
//#Preview {
//    ControlButtonsView(gameViewModel: GameViewModel())
//}
