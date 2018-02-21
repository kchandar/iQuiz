//
//  Question.swift
//  iQuiz
//
//  Created by Keertana Chandar on 2/20/18.
//  Copyright © 2018 Keertana Chandar. All rights reserved.
//

import Foundation

class Question {
    var question:String
    var answers:[String]
    var rightAnswer:Int
    var userAnswer:Int
    
    init(question:String, answers:[String], rightAnswer:Int) {
        self.question = question
        self.answers = answers
        self.rightAnswer = rightAnswer
        self.userAnswer = -1
    }
}

class QuestionFactory {
        
    private var questions:[String:[Question]] = ["math":[Question(question:"2 + 2 = ?", answers:["3", "4", "0", "9"], rightAnswer:2), Question(question:"9 * 3 = ?", answers:["6", "36", "12", "27"], rightAnswer:4), Question(question:"5 + 16 = ?", answers:["19", "20", "21", "22"], rightAnswer:3)], "marvel":[Question(question:"Who is Superman?", answers:["John", "Clark Kent", "Iron Man", "Waldo"], rightAnswer:2), Question(question:"What animal does Antman turn into?", answers:["Ant", "Beetle", "Aunt Mary", "Trick Question"], rightAnswer:1)], "science":[Question(question:"What element is K?", answers:["Karbon", "Pottassium", "Kryptonite", "Iron"], rightAnswer:2)]]
    
    public func getQuestions(topic:String) -> [Question] {
        return self.questions[topic]!
    }
    
    public func changeAnswer(questions:[Question], topic:String, index:Int, userAnswer:Int) -> [Question] {
        questions[index].userAnswer = userAnswer
        self.questions[topic]![index].userAnswer = userAnswer
        return questions
        
    }
}
