//
//  Question.swift
//  Edutainment
//
//  Created by Zach Mommaerts on 9/22/23.
//

import Foundation

struct Question: Identifiable {
    var id = UUID()
    var text: String
    var answer: Int
}
