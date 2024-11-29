//
//  WelcomeView.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 31.10.24.
//

import SwiftUI
import SwiftData

struct BestScoresView: View {

    @EnvironmentObject var gameViewModel: GameViewModel
     @EnvironmentObject  var viewModel: ApiViewModel
     @Namespace var namespace
    @State private var animationGradient = false
    

    var body: some View {
        VStack(alignment: .center) {
            Text("Leaderboard")
                .foregroundStyle(.white)
                .font(.largeTitle)
            if !gameViewModel.stats.isEmpty{
                ScrollView{
                    VStack{
                    let sortedResults = gameViewModel.stats.sorted {
                        if $0.time != $1.time {
                            return $0.time < $1.time // Sort by fastest time first
                        } else {
                            return $0.moves < $1.moves // If time is the same, sort by least moves
                        }
                    }
                        ForEach(0...10,  id: \.self){ index in
                            HStack{
                                Text("\(index + 1).")
                                    .font(.largeTitle)
                                VStack(alignment: .center, spacing: 10){
                                    Text("Some name")
                           
                                HStack{
                                    Text(" Time: \(gameViewModel.timeString(from: sortedResults[index].time))")
                                    Spacer()
                                    Text("Moves: \(sortedResults[index].moves)")
                                }
                                .padding(.horizontal, 80)
                            }
                        }
                            Rectangle()
                                .frame(width: 600, height: 1)
                                .foregroundColor(Color.black)
                    }
                }
                    .padding(.top, 10)
            }.padding(.horizontal, 80)
                    .background(
                    ModalWindowView()
                        .padding(.horizontal, 50)
                    )
            } else{
                ContentUnavailableView(LocalizedStringKey("No Scores yet, play a game!"), systemImage: "house", description: Text("Play a game!"))
            }
    }
        .background{
BackgroundView()
        }
     }
    
}

//
//#Preview {
//   BestScoresView()
//}
