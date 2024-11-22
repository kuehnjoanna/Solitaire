//
//  WelcomeView.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 31.10.24.
//

import SwiftUI
import SwiftData


struct WelcomeView: View {

    @EnvironmentObject var gameViewModel: GameViewModel
     @EnvironmentObject  var viewModel: ApiViewModel
     @Namespace var namespace
    

    var body: some View {
        VStack(alignment: .center) {
            Text("Leaderboard")
            ScrollView{
                let sortedResults = gameViewModel.stats.sorted {
                    if $0.time != $1.time {
                        return $0.time < $1.time // Sort by fastest time first
                    } else {
                        return $0.moves < $1.moves // If time is the same, sort by least moves
                    }
                }
                ForEach(0...10,  id: \.self){ index in
                
                HStack{
                    Text("\(index). Time: \(gameViewModel.timeString(from: sortedResults[index].time))")
                    Spacer()
                    Text("Moves: \(sortedResults[index].moves)")
                }
                .padding(.horizontal, 80)
            }
        }.padding(.horizontal, 80)
    }
     }
    
}


#Preview {
    WelcomeView()
}
