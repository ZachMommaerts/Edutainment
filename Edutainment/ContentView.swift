//
//  ContentView.swift
//  Edutainment
//
//  Created by Zach Mommaerts on 9/17/23.
//

import SwiftUI

struct ContentView: View {
    var numberOfQuestions = [5, 10, 20]
    
    @State private var multiplicationNumber = 6
    @State private var questionAmount = 5
    
    
    var body: some View {
        VStack {
            Stepper("Up to \(multiplicationNumber)", value: $multiplicationNumber, in: 2...12)
            
            Picker("\(questionAmount) questions", selection: $questionAmount) {
                ForEach(numberOfQuestions, id: \.self) { number in
                    Text(String(number))
                }
            }
            .pickerStyle(.segmented)
            
            List(0...questionAmount, id: \.self) { _ in
                Text("\(String(Int.random(in: 2...multiplicationNumber))) x \(String(Int.random(in: 2...multiplicationNumber)))")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
