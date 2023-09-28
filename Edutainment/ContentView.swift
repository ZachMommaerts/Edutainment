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
    @State private var answerInput = ""
    @State private var nonDuplicateQuestions = [[Int]]()
    
    var questions: [Question] {
        var questionsArray = [Question]()
        for _ in 0..<questionAmount {
            var tempArray = [Int]()
            let number1 = Int.random(in: 2...multiplicationNumber)
            let number2 = Int.random(in: 2...multiplicationNumber)
            
            tempArray.append(number1)
            tempArray.append(number2)
            tempArray.sort()
            
            nonDuplicateQuestions.append(tempArray)
            
            let text = "\(number1) x \(number2) = "
            let answer = number1 * number2
            let newQuestion = Question(text: text, answer: answer)
            questionsArray.append(newQuestion)
        }
        return questionsArray
    }
    
    var body: some View {
        VStack {
            Stepper("Up to \(multiplicationNumber)", value: $multiplicationNumber, in: 2...12)
            
            Picker("\(questionAmount) questions", selection: $questionAmount) {
                ForEach(numberOfQuestions, id: \.self) { number in
                    Text(String(number))
                }
            }
            .pickerStyle(.segmented)
            
            List(questions) { question in
                HStack{
                    Text(question.text)
                    TextField("", text: $answerInput)
                }
            }
        }
        .onAppear(perform: generateQuestions)
    }
    
    func generateQuestions() -> Void {
        for _ in 0..<questionAmount {
            var number1 = Int.random(in: 2...multiplicationNumber)
            var number2 = Int.random(in: 2...multiplicationNumber)
            var text = "\(number1) x \(number2) = "
            var answer = number1 * number2
            var newQuestion = Question(text: text, answer: answer)
            //questions.append(newQuestion)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
