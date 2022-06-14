//
//  ContentView.swift
//  GuessFlag
//
//  Created by faruk sirket on 21.11.2021.
//

import SwiftUI
struct FlagImage: View {
    var countries: [String]
    var number: Int
    var body: some View{
        Image(countries[number])
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}
struct Custom: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
            .headerProminence(.increased)
    }
}
extension View{
    func customView() -> some View{
        modifier(Custom())
    }
}

struct ContentView: View {
    @State private var countries = ["Ireland", "UK", "Estonia", "France", "Germany", "Italy", "Nigeria", "Poland", "Russia", "Spain", "US"].shuffled()
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score: Int = 0
    @State private var gameLifes = 0
    @State private var fadeOutOpacity = false
    @State private var isCorrect = false
    @State private var isWrong = false
    @State private var selectedNumber = 0
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.2, green: 0.4, blue: 0.55),location: 0.3),
                .init(color: Color(red: 0.8, green: 0.1, blue: 0.4), location: 0.3)], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the flag")
                    .customView()
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3){number in
                        Button(action: {
                            withAnimation{
                                flagTapped(number)
                            }
                        }) {
                            FlagImage(countries: countries,number: number)
                        }
                        .rotation3DEffect(.degrees(self.isCorrect && self.selectedNumber == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(self.fadeOutOpacity && !(self.selectedNumber == number) ? 0.25 : 1)
                        .rotation3DEffect(.degrees(self.isWrong && self.selectedNumber == number ? 360 : 0), axis: (x: 1, y: 0, z: 0.5))
                    
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .padding()
                Spacer()
                Spacer()
                Text("Score \(score)")
                    .foregroundColor(.white)
                    .font(.title.weight(.medium))
                Spacer()
                
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    func flagTapped (_ number: Int){
        self.selectedNumber = number
        if number == correctAnswer {
            scoreTitle = "Correct"
            self.score += 1
            fadeOutOpacity = true
            isCorrect = true
        } else {
            scoreTitle = "Wrong, that's the flag of \(countries[number])"
            self.score -= 1
            fadeOutOpacity = true
            isWrong = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 / 2){
        showingScore = true
        }
    }
    func askQuestion (){
        self.countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        isCorrect = false
        fadeOutOpacity = false
        isWrong = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
