//
//  ContentView.swift
//  Test
//
//  Created by Vitaliy on 01.03.2024.
//


import SwiftUI


struct ContentView: View {
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var randomNumbers: [[Int]] = Array(repeating: Array(repeating: 0, count: 12), count: 102)
    @State private var selectedIndex: (Int, Int) = (-1, -1)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(0...101, id: \.self) { rowIndex in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(0...11, id: \.self) { cellIndex in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.blue.opacity(0.4))
                                        .frame(width: 80, height: 80)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.blue, lineWidth: 1)
                                        )
                                        
                                    Text("\(randomNumbers[rowIndex][cellIndex])")
                                }
                                
                                .scaleEffect(selectedIndex == (rowIndex, cellIndex) ? 0.8 : 1)
                                .onTapGesture { }
                                .gesture(
                                    DragGesture(minimumDistance: 0)
                                        .onChanged({ _ in
                                            withAnimation(.snappy) {
                                                selectedIndex = (rowIndex, cellIndex)
                                            }
                                        })
                                        .onEnded({ _ in
                                            withAnimation(.snappy) {
                                                selectedIndex = (-1, -1)
                                            }
                                        })
                                )
                        }
                    }
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                }
            }
        }
        .padding(6)
        .onAppear {
            for i in 0...101 {
                for j in 0...11 {
                    randomNumbers[i][j] = generateRundomNumber()
                }
            }
        }
        .onReceive(timer) { _ in
            randomNumbers = randomNumbers.map { row in
                var newRow = row
                newRow[Int.random(in: 0...11)] = generateRundomNumber()
                return newRow
            }
        }
    }
    
    private func generateRundomNumber() -> Int {
        return Int.random(in: 0 ... 1_000)
    }
}

#Preview(body: {
    ContentView()
})
