//
//  BraidView.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 19.11.24.
//

import SwiftUI

struct BraidView: View {
    
    @EnvironmentObject  var gameViewModel: GameViewModel
    var namespace: Namespace.ID
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(gameViewModel.slots[SlotCode.braid.rawValue].indices, id: \.self) { index in
                    let isLastCard = index == gameViewModel.slots[SlotCode.braid.rawValue].indices.last
                    let cardPicture = gameViewModel.slots[SlotCode.braid.rawValue][index].picture
                    CardView(image: cardPicture)
                    
                    .matchedGeometryEffect(id: gameViewModel.slots[SlotCode.braid.rawValue][index].id, in: namespace)
                    .offset(y: 15)
                        .visualEffect { @MainActor content, geometryProxy in
                            content
                                .rotationEffect(
                                    Angle(degrees: index % 2 == 0 ? progress(geometryProxy) * 15 : progress(geometryProxy) * -15)
                                )
                                .offset(
                                    x: index % 2 == 0 ? 15 : -15,
                                    y: CGFloat(index) * 12
                                )
                        }
                        .onTapGesture {
                            if isLastCard {
                                withAnimation(.easeInOut) {
                                    print("id in the braid: \(gameViewModel.slots[SlotCode.braid.rawValue][(index)].id)")
                                    dump(gameViewModel.slots[SlotCode.braid.rawValue])
                                    gameViewModel.slotTapped(slotNum: 14)
                            
                                }
                            }
                        }
                }
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
          //  .padding(.horizontal, 20)
        }
    }
}

//
//#Preview {
//    BraidView()
//}
