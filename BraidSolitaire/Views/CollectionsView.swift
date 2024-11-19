//
//  CollectionsView.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 19.11.24.
//

import SwiftUI

struct CollectionsView: View {
    @EnvironmentObject  var gameViewModel: GameViewModel
    var namespace: Namespace.ID
    @EnvironmentObject  var viewModel: ApiViewModel
    
    let columns = [
        GridItem(.fixed(40)),
        GridItem(.fixed(40))
    ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(SlotCode.collectionsFirst.rawValue...22, id: \.self) { index in
                    if !gameViewModel.slots[index].isEmpty {
                        RoundedRectangle(cornerRadius: 10)
                            .overlay(
                                Image(gameViewModel.slots[index].last!.picture)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 60)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            )
                            .frame(width: 40, height: 60)
                            .matchedGeometryEffect(id: gameViewModel.slots[index].last!.id, in: namespace)
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
//    CollectionsView()
//}
