//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Assistant on 12/19/24.
//

import UIKit

class TriviaViewController: UIViewController {
    
    // MARK: - Properties
    private let triviaGame = TriviaGame()
    private var isShowingResults = false
    
    // MARK: - UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let progressLabel = UILabel()
    private let questionLabel = UILabel()
    private let answerStackView = UIStackView()
    private let answerButtons: [UIButton] = {
        return (0..<4).map { _ in UIButton(type: .system) }
    }()
    
    private let nextButton = UIButton(type: .system)
    private let restartButton = UIButton(type: .system)
    
    private let scoreLabel = UILabel()
    private let resultsLabel = UILabel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TriviaViewController: viewDidLoad called")
        setupUI()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("TriviaViewController: viewWillAppear called")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("TriviaViewController: viewDidAppear called")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        print("TriviaViewController: setupUI called")
        view.backgroundColor = .systemBackground
        
        // Configure scroll view
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Configure progress label
        progressLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        progressLabel.textColor = .systemBlue
        progressLabel.textAlignment = .center
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure question label
        questionLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        questionLabel.textColor = .label
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure answer stack view
        answerStackView.axis = .vertical
        answerStackView.spacing = 12
        answerStackView.distribution = .fillEqually
        answerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure answer buttons
        for (index, button) in answerButtons.enumerated() {
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = 8
            button.tag = index
            button.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            answerStackView.addArrangedSubview(button)
        }
        
        // Configure next button
        nextButton.setTitle("Next Question", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        nextButton.backgroundColor = .systemGreen
        nextButton.layer.cornerRadius = 8
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nextButton.isHidden = true
        
        // Configure restart button
        restartButton.setTitle("Play Again", for: .normal)
        restartButton.setTitleColor(.white, for: .normal)
        restartButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        restartButton.backgroundColor = .systemOrange
        restartButton.layer.cornerRadius = 8
        restartButton.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        restartButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        restartButton.isHidden = true
        
        // Configure score label
        scoreLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        scoreLabel.textColor = .systemGreen
        scoreLabel.textAlignment = .center
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.isHidden = true
        
        // Configure results label
        resultsLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        resultsLabel.textColor = .label
        resultsLabel.textAlignment = .center
        resultsLabel.numberOfLines = 0
        resultsLabel.translatesAutoresizingMaskIntoConstraints = false
        resultsLabel.isHidden = true
        
        // Add all elements to content view
        contentView.addSubview(progressLabel)
        contentView.addSubview(questionLabel)
        contentView.addSubview(answerStackView)
        contentView.addSubview(nextButton)
        contentView.addSubview(restartButton)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(resultsLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Scroll view constraints
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Content view constraints
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Progress label constraints
            progressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            progressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            progressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Question label constraints
            questionLabel.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 30),
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Answer stack view constraints
            answerStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
            answerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            answerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Next button constraints
            nextButton.topAnchor.constraint(equalTo: answerStackView.bottomAnchor, constant: 30),
            nextButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Restart button constraints
            restartButton.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 20),
            restartButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            restartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Score label constraints
            scoreLabel.topAnchor.constraint(equalTo: restartButton.bottomAnchor, constant: 20),
            scoreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            scoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Results label constraints
            resultsLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 20),
            resultsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            resultsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            resultsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - UI Updates
    private func updateUI() {
        print("TriviaViewController: updateUI called")
        if triviaGame.isGameOver {
            print("TriviaViewController: showing results")
            showResults()
        } else {
            print("TriviaViewController: showing question")
            showQuestion()
        }
    }
    
    private func showQuestion() {
        print("TriviaViewController: showQuestion called")
        guard let question = triviaGame.currentQuestion else { 
            print("TriviaViewController: No current question available")
            return 
        }
        
        print("TriviaViewController: Question text: \(question.text)")
        isShowingResults = false
        progressLabel.text = "Question \(triviaGame.currentQuestionNumber) of \(triviaGame.totalQuestions) • \(triviaGame.questionsRemaining) remaining"
        questionLabel.text = question.text
        
        // Show and update answer buttons
        for (index, button) in answerButtons.enumerated() {
            button.setTitle(question.answers[index], for: .normal)
            button.backgroundColor = .systemBlue
            button.isEnabled = true
            button.isHidden = false  // Make sure buttons are visible
        }
        
        // Hide/show appropriate buttons
        nextButton.isHidden = true
        restartButton.isHidden = true
        scoreLabel.isHidden = true
        resultsLabel.isHidden = true
    }
    
    private func showResults() {
        isShowingResults = true
        progressLabel.text = "Quiz Complete!"
        questionLabel.text = "Congratulations!"
        
        // Hide answer buttons
        for button in answerButtons {
            button.isHidden = true
        }
        
        // Show results
        scoreLabel.text = "Your Score: \(triviaGame.correctAnswersCount)/\(triviaGame.totalQuestions)"
        resultsLabel.text = "You got \(triviaGame.correctAnswersCount) out of \(triviaGame.totalQuestions) questions correct!"
        
        // Show appropriate buttons
        nextButton.isHidden = true
        restartButton.isHidden = false
        scoreLabel.isHidden = false
        resultsLabel.isHidden = false
    }
    
    // MARK: - Actions
    @objc private func answerButtonTapped(_ sender: UIButton) {
        let answerIndex = sender.tag
        let isCorrect = triviaGame.answerQuestion(answerIndex)
        
        // Disable all buttons
        for button in answerButtons {
            button.isEnabled = false
        }
        
        // Highlight the selected answer
        if isCorrect {
            sender.backgroundColor = .systemGreen
        } else {
            sender.backgroundColor = .systemRed
        }
        
        // Show the correct answer
        if let question = triviaGame.currentQuestion {
            answerButtons[question.correctAnswer].backgroundColor = .systemGreen
        }
        
        // Show next button or results
        if triviaGame.isGameOver {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.updateUI()
            }
        } else {
            nextButton.isHidden = false
        }
    }
    
    @objc private func nextButtonTapped() {
        triviaGame.nextQuestion()
        updateUI()
    }
    
    @objc private func restartButtonTapped() {
        print("TriviaViewController: restartButtonTapped called")
        triviaGame.resetGame()
        print("TriviaViewController: Game reset, calling updateUI")
        updateUI()
    }
}
