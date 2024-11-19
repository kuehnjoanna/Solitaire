//
//  CardView.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 19.11.24.
//

import SwiftUI

struct EmptyCardView: View {
    var opacity: Double = 0.0
    var apiImage: Hit?
    var apiImageURL: String?
    var body: some View{
        RoundedRectangle(cornerRadius: 10)
            .overlay(
                Group {
                  //  if viewModel.randomImage != nil,
                    if apiImage != nil,
                     //  let imageURLString = viewModel.randomImage?.largeImageURL,
                       let imageURLString = apiImageURL,
                       let imageURL = URL(string: imageURLString) {
                        
                        AsyncImage(url: imageURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .opacity(opacity)
                                .frame(width: 40, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } placeholder: {
                            ProgressView()
                        }
                        
                    } else {
                        // Fallback image or background if URL is invalid or array is empty
                        Image("cardBackground")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .opacity(opacity)
                            .frame(width: 40, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            )
            .frame(width: 40, height: 60)
    }
}

//#Preview {
//    CardView(cardPicture: "")
//}
