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
//            LazyVGrid(columns: [GridItem(.fixed(70))], spacing: 2) {
//                ForEach(SlotCode.cornersFirst.rawValue...13, id: \.self) { index in
//                    if !gameViewModel.slots[index].isEmpty {
//                        RoundedRectangle(cornerRadius: 10)
//                            .overlay(
//                                Image(gameViewModel.slots[index].last!.picture)
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 40, height: 60)
//                                    .clipShape(RoundedRectangle(cornerRadius: 10))
//
//                            )
//                            .frame(width: 40, height: 60)
//                            .matchedGeometryEffect(id: gameViewModel.slots[index].last!.id, in: namespace)
//                            .onTapGesture {
//                                withAnimation(.easeInOut) {
//                                    print("id in the corners: \(gameViewModel.slots[index].last!.id)")
//                                    gameViewModel.slotTapped(slotNum: index)
//                                }
//                            }
//                    } else {
//                        EmptyCardView(opacity: 0.5, apiImage: viewModel.randomImage, apiImageURL: viewModel.randomImage?.largeImageURL)
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                    }
//                }
//            }
            
            
            LazyVGrid(columns: [GridItem(.fixed(70))], spacing: 2) {
                ForEach(SlotCode.cornersFirst.rawValue...(SlotCode.braid.rawValue - 1), id: \.self) { index in
                    if !gameViewModel.slots[index].isEmpty {
                        CardView(image: gameViewModel.slots[index].last!.picture)
                            .matchedGeometryEffect(id: gameViewModel.slots[index].last!.id, in: namespace)
                            .onTapGesture {
                                withAnimation(.easeIn) {
                                    print("cardtapped corners id\(gameViewModel.slots[index].last!.id)")
                                    gameViewModel.slotTapped(slotNum: index)
                                    gameViewModel.autoCollect()
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
