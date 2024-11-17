//
//  InstructionsView.swift
//  BraidSolitaire
//
//  Created by Joanna Kühn on 16.11.24.
//

import SwiftUI
struct DataModel: Identifiable {
    var id = UUID()
    var icon: String
    var title: String
    var details: String
    var tag: Int
}
struct InstructionsView: View {

    let cardData = [
    DataModel(icon: "paintbrush.fill", title: "Brushes", details: "Explore various brushes for different effects.", tag: 0),
    DataModel(icon: "scribble", title: "Sketch", details: "kdjikasuodhassdh", tag: 1),
    DataModel(icon: "square.and.pencil", title: "Shapes", details: "Draw and manipulate shapes with", tag: 2),
    DataModel(icon: "paintpalette.fill", title: "Colors", details: "Choose from a wide range of palletes.", tag: 3),
    DataModel(icon: "sparkle", title: "Effects", details: "Apply effects.", tag: 4)]
    @State var currentPage = 0
    @State var previousPage = 0
    @State var width: CGFloat = 16
    @State var start = false
    @State var iconAnimation = false
    @State var navigateToHome = false
    
    var body: some View {
        VStack{
            TabView(selection: $currentPage, content: {
                ForEach(cardData) { items in
                    CustomStepsCardView(vm: items)
                }
            })
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onChange(of: currentPage){oldValue, newValue in
                handlePageChange(from: oldValue, to: newValue)
            }
            
            
            CustomStepsView(currentPage: $currentPage, numberOfCircles: cardData.count, circleSize: circleSize, width: $width)
            
            CustomSteps(isLastPage: .constant(currentPage == cardData.count - 1), start: $start, goBack: {
                withAnimation{
                    if currentPage > 0 {
                        currentPage -= 1
                    }
                }
            }, next: {
                withAnimation{
                    if currentPage < cardData.count - 1{
                        currentPage += 1
                    }else{
                        
                    }
                }      
            }
            )
        }
    }
    
    func handlePageChange(from oldValue: Int, to newValue: Int){
        updateWidth(newValue)
        previousPage = newValue
    }
    
    func updateWidth(_ newPage: Int){
        withAnimation(.spring(response: 0.5, dampingFraction: 0.5)){
            if newPage == 0{
                start = false
            }
            if newPage > previousPage{
                start = true
                width += 30
            }else{
                width -= 30
            }
        }
        
    }
    
    func circleSize(for index: Int, total: Int) -> CGFloat{
        let minCircleSize: CGFloat = 5
        if index < total / 2 {
            return minCircleSize + CGFloat(index)
        } else {
            return minCircleSize + CGFloat(total - index - 1)
        }
    }
}

#Preview {
    InstructionsView()
}
struct CustomStepsView: View {
    @Binding var currentPage: Int
    let numberOfCircles: Int
    let circleSize: (Int, Int) -> CGFloat
    @Binding var width: CGFloat
    var body: some View {
        HStack(spacing: 0){
            ForEach(0..<numberOfCircles, id: \.self){ index in
                    Circle()
                    .fill(index <= currentPage ? .white : .gray)
                    .frame(width: circleSize(index, numberOfCircles), height: circleSize(index, numberOfCircles))
                    .frame(width: 30)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 30)
                .frame(width: width + 5, height: 20)
                .offset(x: 4)
                .foregroundStyle(.gray), alignment: .leading
        )
        .padding(.vertical)
    }
}


struct BackButton: View {
    @Binding var show: Bool
    var back: () -> Void
    var body: some View{
        Button(action: {back()}, label: {
            
            Image(systemName: "chevron.left")
                .font(.title2)
                .frame(width: show ? 60 : 0, height: 55)
                .background(.thinMaterial, in: Circle())
        })
        .tint(.primary)
    }
}

struct ContinueButton: View {
    @Binding var isLastPage: Bool
    var start: () -> Void
    var body: some View{
        Text(isLastPage ? "Finish" : "Continue")
            .font(.title2)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.blue, in: Capsule())
            .onTapGesture {
                start()
            }
    }
}
struct CustomSteps: View {
    @Binding var isLastPage: Bool
    @Binding var start: Bool
    var goBack: () -> Void
    var next: () -> Void
    var body: some View {
        HStack(spacing: start ? 10 : 0){
            BackButton(show: $start, back: {goBack()})
            ContinueButton(isLastPage: $isLastPage, start: { next()})
        }
        .clipShape(Capsule())
        .padding(.horizontal, 5)
      
  
    }
}
struct CustomStepsCardView: View {
    var vm: DataModel
    var body: some View {
        VStack{
            ZStack{
                Circle().trim(from: 0, to: 0.95)
                    .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                    .frame(width: 120, height: 120)
                    .rotationEffect(.degrees(-20))
                Image(systemName: vm.icon)
                    .font(.system(size: 70))
            }
            Text(vm.title).font(.title.bold())
            Text(vm.details)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.top)
        }
        .padding()
        .frame(width: 300, height: 350)
        .background(.gray, in: .rect(cornerRadius: 20))
        .tag(vm.tag)
    }
}

