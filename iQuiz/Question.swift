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

class QuizFactory {
    
    private var questions:[String: [Question]] = [String: [Question]]()
    private var descriptions: [String:String] = [String: String]()
    var titles: [String] = [String]()
    
    public func getQuestions(topic:String) -> [Question] {
        if (self.questions[topic] != nil) {
            return self.questions[topic]!
        }
        return []
    }
    
    public func getDescription(topic:String) -> String {
        if (self.descriptions[topic] != nil) {
            return self.descriptions[topic]!
        }
        return ""
    }
    
    public func addQuestions(topic:String, question:Question) {
        if questions[topic] == nil {
            questions[topic] = [question]
        } else {
            var qs:[Question] = questions[topic]!
            qs.append(question)
            questions[topic] = qs
        }
    }
    
    public func setDescription(topic:String, desc:String) {
        descriptions[topic] = desc
    }
    
    public func addTitle(topic:String) {
        titles.append(topic)
    }
    
    public func setDescriptions(descriptions:[String:String]) {
        self.descriptions = descriptions
    }
    
    public func setTitles(titles:[String]) {
        self.titles = titles
    }
    
    public func setQuestions(questions:[String: [Question]]) {
        self.questions = questions
    }

}
























