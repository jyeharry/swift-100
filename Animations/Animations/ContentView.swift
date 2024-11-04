//
//  ContentView.swift
//  Animations
//
//  Created by Jye Harry on 21/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 0.0

    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation(.spring(duration: 1.5, bounce: 0.375)) {
                    animationAmount += 360
                }
            }
            .padding(50)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
        }
    }
}

#Preview {
    ContentView()
}
