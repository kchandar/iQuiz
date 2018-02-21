//
//  ViewController.swift
//  iQuiz
//
//  Created by Keertana Chandar on 2/11/18.
//  Copyright © 2018 Keertana Chandar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let pictureArray:[String] = ["math", "marvel", "science"]
    let titleArray:[String] = ["Mathematics", "Marvel Superheroes", "Science"]
    let descriptionArray:[String] = ["Can you pass a simple math quiz?", "How well do you know Superheroes?", "Test your basic science knowledge"]
    var myIndex:Int = 0

    @IBAction func settingsButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictureArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
       
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        
        cell.quizLabel.text = titleArray[indexPath.row]
        cell.quizDescriptionLabel.text = descriptionArray[indexPath.row]
        cell.quizImage.image = UIImage(named: pictureArray[indexPath.row])
        cell.quizImage.layer.cornerRadius = cell.quizImage.frame.height / 2
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "showQuiz", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quizController = segue.destination as! QuizViewController
        let questions:[Question] = QuestionFactory().getQuestions(topic: pictureArray[myIndex])
        let currentQuiz:CurrentQuizInformation = CurrentQuizInformation(title: titleArray[myIndex], questions: questions)
        quizController.currentQuiz = currentQuiz
    }
}

