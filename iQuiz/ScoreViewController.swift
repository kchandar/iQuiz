//
//  ScoreViewController.swift
//  iQuiz
//
//  Created by Keertana Chandar on 2/17/18.
//  Copyright © 2018 Keertana Chandar. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    var total:Int = 0
    var score:Int = 0
    var titleString:String = ""
    var currentQuiz:CurrentQuizInformation = CurrentQuizInformation(title: "", questions: [], factory: QuizFactory())
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleString
        let percentage:Double = Double(score) / Double(total)
        let scoreText:String = "\(score) / \(total)"
        var descText:String = ""
        if(percentage == 0) {
            descText = "Try harder next time D:"
        } else if percentage < 0.5 {
            descText = "Not absolutely terrible..."
        } else if percentage < 0.75 {
            descText = "So close!"
        } else if percentage == 1 {
            descText = "Amazing!"
        }
        scoreLabel.text = scoreText
        descLabel.text = descText
    }
    
    
    @IBAction func goHome(_ sender: UIButton) {
        performSegue(withIdentifier: "goHome", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goHome" {
            let controller = segue.destination as! ViewController
            controller.tempFactory = currentQuiz.factory
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
