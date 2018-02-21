//
//  UserInformation.swift
//  iQuiz
//
//  Created by Keertana Chandar on 2/20/18.
//  Copyright © 2018 Keertana Chandar. All rights reserved.
//

import Foundation

class CurrentQuizInformation {
    var currentIndex:Int
    var questions:[Question]
    var totalScore:Int
    var title:String
    
    init(title:String, questions:[Question]) {
        self.currentIndex = 0
        self.totalScore = 0
        self.questions = questions
        self.title = title
    }
    
    public func incrementIndex() {
        currentIndex += 1
    }
    
    public func incrementTotalScore() {
        totalScore += 1
    }
    
    public func getCurrentQuestion() -> String {
        return questions[currentIndex].question
    }
    
    public func getCurrentAnswers() -> [String] {
        return questions[currentIndex].answers
    }
    
    public func getCurrentRightAnswer() -> Int {
        return questions[currentIndex].rightAnswer
    }
    
    public func getCurrentUserAnswer() -> Int {
        return questions[currentIndex].userAnswer
    }
    
    public func setCurrentUserAnswer(_ userAnswer:Int) {
        questions[currentIndex].userAnswer = userAnswer
    }
    
    public func isLastQuestion() -> Bool {
        return currentIndex > questions.count - 2
    }
    
    
    
    
}
