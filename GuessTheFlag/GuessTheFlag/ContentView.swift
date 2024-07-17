//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jye Harry on 17/7/2024.
//

import SwiftUI

struct ContentView: View {
  @State private var countries = [
    "Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain",
    "UK", "US"
  ].shuffled()
  @State private var correctAnswer = Int.random(in: 0...2)

  @State private var showingScore = false
  @State private var scoreTitle = ""

  var body: some View {
    ZStack {
      Color.blue
        .ignoresSafeArea()

      VStack(spacing: 30) {
        VStack {
          Text("Tap the flag of")
            .foregroundColor(.white)
          Text(countries[correctAnswer])
            .foregroundColor(.white)
        }

        ForEach(0..<3) { number in
          Button {
            flagTapped(number)
          } label: {
            Image(countries[number])
          }
        }
      }
    }
    .alert(scoreTitle, isPresented: $showingScore) {
      Button("Continue", action: askQuestion)
    } message: {
      Text("Your score is ???")
    }
  }

  func flagTapped(_ number: Int) {
    scoreTitle =
      number == correctAnswer
      ? "Correct"
      : "Wrong"

    showingScore = true
  }

  func askQuestion() {
    countries = countries.shuffled()
    correctAnswer = Int.random(in: 0...2)
  }
}

#Preview {
  ContentView()
}
