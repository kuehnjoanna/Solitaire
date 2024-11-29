
import SwiftUI

struct ContentView: View {
    @State private var showSplash = true
    @State private var animationGradient = false
    @EnvironmentObject  var gameViewModel: GameViewModel
    var body: some View {
        ZStack {
            if showSplash{
                withAnimation(.easeInOut(duration: 5)){
                    SplashScreenView()
                        .transition(.opacity)
                }
            } else {
                
                withAnimation(.easeInOut(duration: 15)){
                    MenuView()
                        .environmentObject(gameViewModel)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background{
            LinearGradient(colors: [Color("BraidGreenShadow"), Color("BraidGreen")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .hueRotation(.degrees(45))
                .onAppear{
                    withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)){
                        animationGradient.toggle()
                    }
                }
        }
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                withAnimation(.easeInOut(duration: 1)){
                    self.showSplash = false
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
