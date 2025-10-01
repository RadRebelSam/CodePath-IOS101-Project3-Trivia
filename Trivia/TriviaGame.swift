//
//  TriviaGame.swift
//  Trivia
//
//  Created by Assistant on 12/19/24.
//

import Foundation

class TriviaGame {
    private var questions: [Question] = []
    private var currentQuestionIndex = 0
    private var score = 0
    private var userAnswers: [Int] = [] // Store user's answers
    
    init() {
        setupQuestions()
    }
    
    private func setupQuestions() {
        questions = [
            Question(
                text: "What is the capital of France?",
                answers: ["London", "Berlin", "Paris", "Madrid"],
                correctAnswer: 2
            ),
            Question(
                text: "Which planet is known as the Red Planet?",
                answers: ["Venus", "Mars", "Jupiter", "Saturn"],
                correctAnswer: 1
            ),
            Question(
                text: "What is the largest mammal in the world?",
                answers: ["African Elephant", "Blue Whale", "Giraffe", "Hippopotamus"],
                correctAnswer: 1
            ),
            Question(
                text: "Who painted the Mona Lisa?",
                answers: ["Vincent van Gogh", "Pablo Picasso", "Leonardo da Vinci", "Michelangelo"],
                correctAnswer: 2
            ),
            Question(
                text: "What is the chemical symbol for gold?",
                answers: ["Go", "Gd", "Au", "Ag"],
                correctAnswer: 2
            )
        ]
    }
    
    // MARK: - Game State
    
    var currentQuestion: Question? {
        guard currentQuestionIndex < questions.count else { return nil }
        return questions[currentQuestionIndex]
    }
    
    var isGameOver: Bool {
        return currentQuestionIndex >= questions.count
    }
    
    var totalQuestions: Int {
        return questions.count
    }
    
    var currentQuestionNumber: Int {
        return currentQuestionIndex + 1
    }
    
    var questionsRemaining: Int {
        return totalQuestions - currentQuestionNumber
    }
    
    var finalScore: Int {
        return score
    }
    
    var correctAnswersCount: Int {
        return score
    }
    
    // MARK: - Game Actions
    
    func answerQuestion(_ answerIndex: Int) -> Bool {
        guard let question = currentQuestion else { return false }
        
        userAnswers.append(answerIndex)
        let isCorrect = answerIndex == question.correctAnswer
        
        if isCorrect {
            score += 1
        }
        
        return isCorrect
    }
    
    func nextQuestion() {
        currentQuestionIndex += 1
    }
    
    func resetGame() {
        print("TriviaGame: resetGame called")
        currentQuestionIndex = 0
        score = 0
        userAnswers.removeAll()
        print("TriviaGame: Game reset - currentQuestionIndex: \(currentQuestionIndex), score: \(score)")
    }
    
    func getUserAnswer(for questionIndex: Int) -> Int? {
        guard questionIndex < userAnswers.count else { return nil }
        return userAnswers[questionIndex]
    }
}
