//
//  ModalWindowView.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 29.11.24.
//

import SwiftUI

struct ModalWindowView: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .opacity(0.1)
                .background(
                    Color.white
                        .opacity(0.08)
                        .blur(radius: 10)
                )
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(
                            .linearGradient(.init(colors: [
                                Color("BraidGreen2"),
                                Color("BraidGreen").opacity(0.5),
                                .clear,
                                Color("BraidGreen").opacity(0.5),
                                Color("BraidGreen2"),
                            ]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2.5
                        )
                )
        }
    }
}

#Preview {
    ModalWindowView()
}
