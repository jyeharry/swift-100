//
//  ContentView.swift
//  WeSplit
//
//  Created by Jye Harry on 15/7/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var chequeAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20

    let tipPercentages = [10, 15, 20, 25, 0]

    var body: some View {
        Form {
            Section {
                TextField("Amount", value: $chequeAmount, format: .currency(code: Locale.current.currency?.identifier ?? "AUD")).keyboardType(.decimalPad)
            }

            Section {
                Text(chequeAmount, format: .currency(code: Locale.current.currency?.identifier ?? "AUD"))
            }
        }
    }
}

#Preview {
    ContentView()
}
