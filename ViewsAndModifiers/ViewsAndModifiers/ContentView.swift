//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Jye Harry on 18/7/2024.
//

import SwiftUI

struct GridStack<Content: View>: View {
  let rows: Int
  let columns: Int
  let content: (Int, Int) -> Content

  var body: some View {
    VStack {
      ForEach(0..<rows, id: \.self) { row in
        HStack {
          ForEach(0..<columns, id: \.self) { column in
            content(row, column)
          }
        }
      }
    }
  }
}

struct ContentView: View {
  var body: some View {
    GridStack(rows: 4, columns: 4) { row, col in
      Text("R\(row) C\(col)")
    }
  }
}

#Preview {
  ContentView()
}
