//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Keertana Chandar on 2/20/18.
//  Copyright © 2018 Keertana Chandar. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    var currentQuiz:CurrentQuizInformation = CurrentQuizInformation(title: "", questions:[])
 
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func onNextClick(_ sender: UIButton) {
        if(currentQuiz.isLastQuestion()) {
            print("score")
            performSegue(withIdentifier: "showScore", sender: self)
        } else {
            print("quiz")
            currentQuiz.incrementIndex()
            performSegue(withIdentifier: "goBackToQuiz", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadScreen()
        loadCorrectAnswers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func loadScreen() {
        titleLabel.text = currentQuiz.title
        questionLabel.text = currentQuiz.questions[currentQuiz.currentIndex].question
        let answers:[String] = currentQuiz.getCurrentAnswers()
        button1.setTitle(answers[0], for: .normal)
        button2.setTitle(answers[1], for: .normal)
        button3.setTitle(answers[2], for: .normal)
        button4.setTitle(answers[3], for: .normal)
    }
    
    private func loadCorrectAnswers() {
        if(currentQuiz.isLastQuestion()) {
            nextButton.setTitle("See My Score", for: .normal)
        }
        let users:Int = currentQuiz.getCurrentUserAnswer()
        let correct:Int = currentQuiz.getCurrentRightAnswer()
            if (users != correct) {
                switch(users) {
                case 1:
                    button1.layer.backgroundColor = UIColor.red.cgColor
                    break
                case 2:
                    button2.layer.backgroundColor = UIColor.red.cgColor
                    break
                case 3:
                    button3.layer.backgroundColor = UIColor.red.cgColor
                    break
                case 4:
                    button4.layer.backgroundColor = UIColor.red.cgColor
                    break
                default:
                    break
                }
            }
            switch(correct) {
            case 1:
                button1.layer.backgroundColor = UIColor.green.cgColor
                break
            case 2:
                button2.layer.backgroundColor = UIColor.green.cgColor
                break
            case 3:
                button3.layer.backgroundColor = UIColor.green.cgColor
                break
            case 4:
                button4.layer.backgroundColor = UIColor.green.cgColor
                break
            default:
                break
            }
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showScore"?:
            let scoreController = segue.destination as! ScoreViewController
            scoreController.titleString = currentQuiz.title
            scoreController.total = currentQuiz.questions.count
            scoreController.score = currentQuiz.totalScore
            break
        case "goBackToQuiz"?:
            let quizController = segue.destination as! QuizViewController
            quizController.currentQuiz = currentQuiz
            break
        default:
            break
        }
    }

}
