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
    @State private var answerInput = Array(repeating: "", count: 20)
    @State private var answersChecked = false
    @State private var score = 0
    @State private var questionsArray = Array(repeating: Question(text: "", answer: 12), count: 20)
    @FocusState private var textIsFocused: Bool
    
    var questions: [Question] {
        var questionsArray = [Question]()
        for _ in 0..<20 {
            let number1 = Int.random(in: 2...multiplicationNumber)
            let number2 = Int.random(in: 2...multiplicationNumber)
            
            let text = "\(number1) x \(number2) = "
            let answer = number1 * number2
            let newQuestion = Question(text: text, answer: answer)
            questionsArray.append(newQuestion)
        }
        return questionsArray
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Stepper("Up to \(multiplicationNumber)", value: $multiplicationNumber, in: 2...12)
                        .fixedSize()
                    Spacer()
                    Button("Create Worksheet", action: generateQuestions)
                }
                
                Picker("\(questionAmount) questions", selection: $questionAmount) {
                    ForEach(numberOfQuestions, id: \.self) { number in
                        Text(String(number))
                    }
                }
                .background(difficultyColor())
                .pickerStyle(.segmented)
                .animation(.default, value: questionAmount)
                
                Text(answersChecked ? "Score: \(score) / \(questionAmount)" : "Score:  / \(questionAmount)")
                
                List(0..<questionAmount, id: \.self) { index in
                    HStack {
                        Text(questionsArray[index].text)
                        TextField("", text: $answerInput[index])
                            .keyboardType(.decimalPad)
                            .focused($textIsFocused)
                    }
                    .foregroundColor(answerStatus(answer: questionsArray[index].answer, guess: answerInput[index]))
                }
                .scrollContentBackground(.hidden)
                .animation(.default, value: answersChecked)

                Button("Check Answers", action: checkAnswers)
            }
            .navigationTitle("Edutainment")
            .padding()
            .background(.blue)
            .onAppear(perform: generateQuestions)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        textIsFocused = false
                    }
                }
            }
        }
        .foregroundColor(.white)
    }
    
    func generateQuestions() -> Void {
        score = 0
        answersChecked = false
        questionsArray = Array(repeating: Question(text: "", answer: 12), count: 20)
        for index in 0..<20 {
            let number1 = Int.random(in: 2...multiplicationNumber)
            let number2 = Int.random(in: 2...multiplicationNumber)
        
            let text = "\(number1) x \(number2) = "
            let answer = number1 * number2
            let newQuestion = Question(text: text, answer: answer)
            questionsArray[index] = newQuestion
        }
    }
    
    func checkAnswers() -> Void {
        answersChecked = true
        score = 0
        for index in 0...questionAmount {
            if(questionsArray[index].answer == Int(answerInput[index])) {
                score += 1
            }
        }
    }
    
    func difficultyColor() -> Color {
        
        switch questionAmount {
        case 5:
            return .green
        case 10:
            return .yellow
        case 20:
            return .red
        default:
            return .white
        }
    }
    
    func answerStatus(answer: Int , guess: String) -> Color{
        guard answersChecked != false else {
            return .black
        }
        
        if String(answer) == guess {
            return .green
        } else {
            return .red
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
