//
//  QuizViewController.swift
//  iQuiz
//
//  Created by Keertana Chandar on 2/17/18.
//  Copyright © 2018 Keertana Chandar. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    var userAnswer:Int = -1
    var currentQuiz:CurrentQuizInformation = CurrentQuizInformation(title: "", questions:[], factory: QuizFactory())


    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var submitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuiz()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onSubmit(_ sender: UIButton) {
        if(userAnswer != -1) {
            let rightAnswer = currentQuiz.getCurrentRightAnswer()
            if(userAnswer == rightAnswer) {
                currentQuiz.incrementTotalScore()
            }
            performSegue(withIdentifier: "showAnswer", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showAnswer") {
            let answerController = segue.destination as! AnswerViewController
            answerController.currentQuiz = currentQuiz
        } else if(segue.identifier == "goHome") {
            let controller = segue.destination as! ViewController
            controller.tempFactory = currentQuiz.factory
        }
    }
    
    @IBAction func chooseAnswer(_ sender: UIButton) {
        button1.layer.borderColor = UIColor.black.cgColor
        button2.layer.borderColor = UIColor.black.cgColor
        button3.layer.borderColor = UIColor.black.cgColor
        button4.layer.borderColor = UIColor.black.cgColor
        sender.layer.borderColor = UIColor.purple.cgColor
        currentQuiz.setCurrentUserAnswer(sender.tag)
        userAnswer = sender.tag
    }
    
    public func clearAnswers() {
        button1.layer.backgroundColor = UIColor.white.cgColor
        button2.layer.backgroundColor = UIColor.white.cgColor
        button3.layer.backgroundColor = UIColor.white.cgColor
        button4.layer.backgroundColor = UIColor.white.cgColor
        button1.layer.borderColor = UIColor.black.cgColor
        button2.layer.borderColor = UIColor.black.cgColor
        button3.layer.borderColor = UIColor.black.cgColor
        button4.layer.borderColor = UIColor.black.cgColor
        loadQuiz()
    }
    
    
    public func loadQuiz() {
        titleLabel.text = currentQuiz.title
        questionLabel.text = currentQuiz.questions[currentQuiz.currentIndex].question
        let answers:[String] = currentQuiz.getCurrentAnswers()
        button1.setTitle(answers[0], for: .normal)
        button2.setTitle(answers[1], for: .normal)
        button3.setTitle(answers[2], for: .normal)
        button4.setTitle(answers[3], for: .normal)
    }

}
