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
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

//        titleLabel.text = "Titlee"
//        scoreLabel.text = "SCORREE"
        // Do any additional setup after loading the view.
        titleLabel.text = titleString
        
        
        scoreLabel.text = "Good job! \(score) / \(total)"
    }
    
    
    @IBAction func goHome(_ sender: UIButton) {
        performSegue(withIdentifier: "goHome", sender: self)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
