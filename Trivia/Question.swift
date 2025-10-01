//
//  Question.swift
//  Trivia
//
//  Created by Assistant on 12/19/24.
//

import Foundation

struct Question {
    let text: String
    let answers: [String]
    let correctAnswer: Int // Index of the correct answer (0-3)
    
    init(text: String, answers: [String], correctAnswer: Int) {
        self.text = text
        self.answers = answers
        self.correctAnswer = correctAnswer
    }
}
