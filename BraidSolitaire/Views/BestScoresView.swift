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
    @State private var name: String = ""
    @State private var name2: Bool = false
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(alignment: .center) {
            Text("Leaderboard")
                .foregroundStyle(.white)
                .font(.largeTitle)
            if !gameViewModel.stats.isEmpty{
               // dump(gameViewModel.stats)
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
                            if index <
                                sortedResults.count {
                            HStack{
                                Text("\(index + 1).")
                                    .font(.largeTitle)
                                VStack(alignment: .center, spacing: 10){
                                    // because this part is added later, we dont want to have an error in case name is empty
                                  
                                    HStack{
                                        Spacer()
                                        Text(sortedResults[index].name)
                                        Spacer()
                                        Button("edit"){
                                            gameViewModel.isSheetPresented = true
                                        }
                                        Button("delete"){
                                            gameViewModel.deleteResult(result: sortedResults[index])
                                            dismiss()
                                        }
                                    }
                                    
                                    HStack{
                                        Text(" Time: \(gameViewModel.timeString(from: sortedResults[index].time))")
                                        Spacer()
                                        Text("Moves: \(sortedResults[index].moves)")
                                    }
                                    .padding(.horizontal, 80)
                                }
                            }
                            .sheet(isPresented: $gameViewModel.isSheetPresented){
                                VStack {
                                    Text("What is your name?")
                                        .font(.title)
                                        .padding()
                                    TextField("name", text: $name)
                                   // Text(errorMessage)
                                    HStack{
                                    Button(action: {
                                        if name.isEmpty{
                                     //       errorMessage = "Name can't be empty!"
                                        } else {
                                            gameViewModel.updateResultsName(result: sortedResults[index], newName: name)
                                         //
                                            dismiss() // Dismiss the sheet
                                        }
                                    }) {
                                        Text("Save")
                                            .padding()
                                            .background(Color.red)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                    }
                                        
                                        Button("close"){
                                            dismiss()
                                        }
                                }
                                }
                            }
                                Rectangle()
                                    .frame(width: 600, height: 1)
                                    .foregroundColor(Color.black)
                        }
                         
                    }
                }
                    .padding(.top, 10)
            }.padding(.horizontal, 80)
                    .background(
                    ModalWindowView()
                        .padding(.horizontal, 50)
                    )
            } else{
                ///////ADJUST!  
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
