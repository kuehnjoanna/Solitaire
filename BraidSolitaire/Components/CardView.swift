//
//  CardView.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 19.11.24.
//

import SwiftUI

struct CardView: View {
var image: String
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .overlay(
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
            )
            .frame(width: 40, height: 60)    }
}

#Preview {
    CardView(image: "cardBackground")
}
