//
//  ContentView.swift
//  WeSplit
//
//  Created by Jye Harry on 15/7/2024.
//

import SwiftUI

struct ContentView: View {
  @State private var checkAmount = 0.0
  @State private var numberOfPeople = 2
  @State private var tipPercentage = 20
  @FocusState private var amountIsFocused: Bool

  let tipPercentages = [10, 15, 20, 25, 0]

  var grandTotal: Double {
    let tipSelection = Double(tipPercentage)

    let tipValue = checkAmount / 100 * tipSelection
    return checkAmount + tipValue
  }

  var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople + 2)
    return grandTotal / peopleCount
  }

  var body: some View {
    NavigationStack {
      Form {
        Section {
          TextField(
            "Amount", value: $checkAmount,
            format: .currency(code: Locale.current.currency?.identifier ?? "AUD")
          )
          .keyboardType(.decimalPad)
          .focused($amountIsFocused)

          Picker("Number of People", selection: $numberOfPeople) {
            ForEach(2..<100) {
              Text("\($0) people")
            }
          }
        }

        Section("How much do you want to tip?") {
          Picker("Tip percentage", selection: $tipPercentage) {
            ForEach(0..<101, id: \.self) {
              Text($0, format: .percent)
            }
          }
          .pickerStyle(.navigationLink)
        }

        Section("Total") {
          Text(
            grandTotal,
            format: .currency(code: Locale.current.currency?.identifier ?? "AUD"))
          .foregroundColor(tipPercentage == 0 ? .red : .black)
        }

        Section("Amount per person") {
          Text(
            totalPerPerson,
            format: .currency(code: Locale.current.currency?.identifier ?? "AUD"))
        }
      }
      .navigationTitle("WeSplit")
      .toolbar {
        if amountIsFocused {
          Button("Done") {
            amountIsFocused = false
          }
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
