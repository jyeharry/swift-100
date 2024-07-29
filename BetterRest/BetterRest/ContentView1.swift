//
//  ContentView.swift
//  BetterRest
//
//  Created by Jye Harry on 29/7/2024.
//

import SwiftUI

struct ContentView1: View {
  @State private var sleepAmount = 8.0
  @State private var wakeUp = Date.now
    var body: some View {
      VStack {
        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)

        DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...Date.now.addingTimeInterval(86400))
          .labelsHidden()
        
        Text(Date.now, format: .dateTime.hour().minute().year().day().month())

        Text(Date.now.formatted(date: .long, time: .shortened))
      }
      .padding()
    }

  func exampleDates() {
    let components = Calendar.current.dateComponents([.hour, .minute], from: .now)
    let hour = components.hour ?? 0
    let minute = components.minute ?? 0
  }
}

#Preview {
    ContentView1()
}
