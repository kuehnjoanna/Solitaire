//
//  SplashScreenView.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 29.11.24.
//

import SwiftUI
import AVKit

struct SplashScreenView: View {
    @State private var player: AVPlayer? = {
        if let bundle = Bundle.main.path(forResource: "Braid-4", ofType: "mp4"){
            return .init(url: URL(filePath: bundle))
        }
        return nil
    }()
    
    var body: some View {
        VStack{
            ZStack{
                if let player{
                    CustomVideoPlayer(player: player)
                        .edgesIgnoringSafeArea(.all)
                }
            }
        }.ignoresSafeArea()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .onAppear(){
                player?.play()
            }
            .onDisappear(){
                player?.pause()
            }
    }
}

#Preview {
    SplashScreenView()
}
struct CustomVideoPlayer: UIViewControllerRepresentable {
    var player: AVPlayer
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        
        return controller
    }
    
    func updateUIViewController (_ uiViewController: AVPlayerViewController, context: Context){
        
    }
}
