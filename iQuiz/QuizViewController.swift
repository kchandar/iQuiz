//
//  QuizViewController.swift
//  iQuiz
//
//  Created by Keertana Chandar on 2/17/18.
//  Copyright © 2018 Keertana Chandar. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    var titleString:String = ""
    var questions:[String] = [""]
    var answerChoices:[[String]] = [[""]]
    var correctAnswers:[Int] = [-1]
    var totalQuestions:Int = 0
    var totalScore:Int = 0
    var currentIndex:Int = 0
    var userAnswer:Int = 0
    var isQuestion:Bool = true
    

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var submitButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(questions)
        titleLabel.text = titleString
        totalQuestions = questions.count
        loadQuiz()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onSubmit(_ sender: UIButton) {
        //titleLabel.text = "UserTag = \(userAnswer)"
            if(isQuestion) {
                let rightAnswer = correctAnswers[currentIndex]
                
                if(currentIndex < totalQuestions) {
                    clearAnswers()
                    submitButton.setTitle("Next", for: .normal)
                } else {
                    submitButton.setTitle("See My Score", for: .normal)
                }
                currentIndex += 1
                if (rightAnswer != userAnswer) {
                    switch(userAnswer) {
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
                } else {
                    totalScore += 1
                }
                switch(rightAnswer) {
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
                    isQuestion = false
            } else {
                isQuestion = true
                if(currentIndex < totalQuestions) {
                    clearAnswers()
                    submitButton.setTitle("Submit", for: .normal)
                } else {
                    performSegue(withIdentifier: "showScore", sender: self)
                }
            }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let scoreController = segue.destination as! ScoreViewController
        scoreController.titleString = titleString
        scoreController.total = totalQuestions
        scoreController.score = totalScore
    }
    
    @IBAction func chooseAnswer(_ sender: UIButton) {
        //titleLabel.text = "\(sender.tag)"
        userAnswer = sender.tag
    }
    
    public func clearAnswers() {
        button1.layer.backgroundColor = UIColor.gray.cgColor
        button2.layer.backgroundColor = UIColor.gray.cgColor
        button3.layer.backgroundColor = UIColor.gray.cgColor
        button4.layer.backgroundColor = UIColor.gray.cgColor
        loadQuiz()
    }
    
    
    public func loadQuiz() {
        questionLabel.text = questions[currentIndex]
        button1.setTitle(answerChoices[currentIndex][0], for: .normal)
        button2.setTitle(answerChoices[currentIndex][1], for: .normal)
        button3.setTitle(answerChoices[currentIndex][2], for: .normal)
        button4.setTitle(answerChoices[currentIndex][3], for: .normal)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
