//
//  ContentView.swift
//  BetterRest
//
//  Created by Jye Harry on 29/7/2024.
//

import CoreML
import SwiftUI

struct ContentView: View {
  @State private var wakeUp = defaultWakeTime
  @State private var sleepAmount = 8.0
  @State private var coffeeAmount = 1

  static var defaultWakeTime: Date {
    var components = DateComponents()
    components.hour = 7
    components.minute = 0
    return Calendar.current.date(from: components) ?? .now
  }

  var body: some View {
    NavigationStack {
      Form {
        Section("When do you want to wake up?") {
          DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
            .labelsHidden()
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
        }

        Section("Desired amount of sleep") {
          Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
        }

        Section("Daily coffee intake") {
          Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 0...20)
        }
        
        Section("Your ideal bedtime") {
          Text(calculateBedtime())
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        }
      }
      .navigationTitle("BetterRest")
    }
  }

  func calculateBedtime() -> String {
    var message = ""
    do {
      let config = MLModelConfiguration()
      let model = try SleepCalculator(configuration: config)

      let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
      let hour = (components.hour ?? 0) * 60 * 60
      let minute = (components.minute ?? 0) * 60

      let prediction = try model.prediction(
        wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

      let sleepTime = wakeUp - prediction.actualSleep
      message = sleepTime.formatted(date: .omitted, time: .shortened)
    } catch {
      message = "Sorry, there was a problem calculating your bedtime."
    }

    return message
  }
}

#Preview {
  ContentView()
}
