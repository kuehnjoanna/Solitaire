//
//  BraidSolitaireApp.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 30.10.24.
//

import SwiftUI
import SwiftData

@main
struct BraidSolitaireApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var gameViewModel: GameViewModel = GameViewModel(
           context: ModelContext(ModelContextProvider.container)
       )
    var body: some Scene {
        WindowGroup {
        //  GameView()
        //  WelcomeView()
            ContentView()
                .environmentObject(gameViewModel)
        }
        .onChange(of: scenePhase) { newPhase in
            switch newPhase {
            case .background, .inactive:
                if gameViewModel.isItOver {
                    gameViewModel.saveGameState()
                    print("inactive \(gameViewModel.timePassed)")
                }
            case .active:
                if !gameViewModel.isItOver {
                    gameViewModel.clearSavedGameState()
                    print("active \(gameViewModel.timePassed)")
                }
            default:
                break
            }
        }
      //  .modelContainer(DataManager.container)
    }
    
}
