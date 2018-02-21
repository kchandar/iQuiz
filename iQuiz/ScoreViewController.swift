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
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleString
        let scoreText:String = "\(score) / \(total)"
        var descText:String = ""
        if( score == 0) {
            descText = "You need some work!"
        } else if (score == total) {
            descText = "Perfect!"
        } else {
            descText = "Almost!"
        }
        scoreLabel.text = scoreText
        descLabel.text = descText
    }
    
    
    @IBAction func goHome(_ sender: UIButton) {
        performSegue(withIdentifier: "goHome", sender: self)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
