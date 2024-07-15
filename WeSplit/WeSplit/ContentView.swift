//
//  ContentView.swift
//  WeSplit
//
//  Created by Jye Harry on 15/7/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    var body: some View {
        Form {
            TextField("Enter your name", text: $name)
            Text("Hello, \(name == "" ? "World" : name)!")
        }
    }
}

#Preview {
    ContentView()
}
