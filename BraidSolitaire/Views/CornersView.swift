//
//  CornersView.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 19.11.24.
//

import SwiftUI

struct CornersView: View {
    @EnvironmentObject   var gameViewModel: GameViewModel
    var namespace: Namespace.ID
    @EnvironmentObject  var viewModel: ApiViewModel
    
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(.fixed(70))], spacing: 2) {
                ForEach(SlotCode.cornersFirst.rawValue...(SlotCode.braid.rawValue - 1), id: \.self) { index in
                    if !gameViewModel.slots[index].isEmpty {
                        CardView(image: gameViewModel.slots[index].last!.picture)
                            .matchedGeometryEffect(id: gameViewModel.slots[index].last!.id, in: namespace)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    gameViewModel.slotTapped(slotNum: index)
                                    gameViewModel.autoCollect()
                                    print("cardtapped id\(index)")
                                }
                            }
                    } else {
                        EmptyCardView(opacity: 0.5, apiImage: viewModel.randomImage, apiImageURL: viewModel.randomImage?.largeImageURL)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
        }
    }
}
//
//#Preview {
//    CornersView()
//}
