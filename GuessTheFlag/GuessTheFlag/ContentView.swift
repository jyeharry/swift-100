//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jye Harry on 17/7/2024.
//

import SwiftUI

struct FlagImage: View {
    var country: String

    var body: some View {
        Image(country)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundStyle(.blue)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain",
        "UK", "US"
    ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var gamesPlayed = 0
    @State private var isFinalGame = false

    @State private var selectedFlag: Int? = nil
    @State private var rotationAmount: Double = 0

    var body: some View {
        ZStack {
            RadialGradient(
                stops: [
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
                ], center: .top, startRadius: 200, endRadius: 700
            )
            .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess the Flag")
                    .titleStyle()

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0 ..< 3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(country: countries[number])
                                .rotation3DEffect(
                                    .degrees(selectedFlag == number ? 360 : 0),
                                    axis: (x: 0, y: 1, z: 0)
                                )
                                .opacity(selectedFlag == nil || selectedFlag == number ? 1 : 0.25)
                                .animation(selectedFlag == nil ? nil : .easeInOut(duration: 1), value: selectedFlag)
                                .scaleEffect(selectedFlag == nil || selectedFlag == number ? 1 : 0.9)
                                .animation(selectedFlag == nil ? nil : .easeInOut(duration: 0.5), value: selectedFlag)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("You scored \(score) out of 8", isPresented: $isFinalGame) {
            Button("Reset", action: resetGame)
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }

        gamesPlayed += 1
        if gamesPlayed == 8 {
            isFinalGame = true
        }
        showingScore = true
        
        selectedFlag = number
//        rotationAmount += 360
    }

    func askQuestion() {
        selectedFlag = nil
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }

    func resetGame() {
        score = 0
        gamesPlayed = 0
        
        selectedFlag = nil
    }
}

#Preview {
    ContentView()
}
