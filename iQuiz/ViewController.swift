//
//  ViewController.swift
//  iQuiz
//
//  Created by Keertana Chandar on 2/11/18.
//  Copyright © 2018 Keertana Chandar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var titleArray:[String] = [String]()
    var myIndex:Int = 0
    var link:String = "http://tednewardsandbox.site44.com/questions.json"
    var factory:QuizFactory = QuizFactory()
    var tempFactory:QuizFactory = QuizFactory(questions: ["Mathematics":[Question(question:"What is 2+2?", answers:["4", "22", "An irrational number", "Nobody knows"], rightAnswer:1)], "Marvel Super Heroes":[Question(question:"Who is Iron Man?", answers:["Tony Stark", "Obadiah Stane", "A rock hit by Megadeth", "Nobody knows"], rightAnswer:1), Question(question:"Who founded the X-Men?", answers:["Tony Stark", "Professor X", "The X-Institute", "Erik Lensherr"], rightAnswer:2), Question(question:"How did Spider-Man get his powers?", answers:["He was bitten by a radioactive spider", "He ate a radioactive spider", "He is a radioactive spider", "He looked at a radioactive spider"], rightAnswer:1)], "Science!":[Question(question:"What is fire?", answers:["One of the four classical elements", "A magical reaction given to us by God", "A band that hasn't yet been discovered", "Fire! Fire! Fire! heh-heh"], rightAnswer:1)]], descriptions: ["Science!": "Because SCIENCE!", "Marvel Super Heroes": "Avengers, Assemble!", "Mathematics": "Did you pass the third grade?"], titles: ["Science!", "Marvel Super Heroes", "Mathematics"], link: "http://tednewardsandbox.site44.com/questions.json")

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        factory = tempFactory
        titleArray = factory.titles
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factory.titles.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quizTitle = factory.titles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        
        cell.quizLabel.text = quizTitle
        cell.quizDescriptionLabel.text = factory.getDescription(topic: quizTitle)
        cell.quizImage.image = UIImage(named: "science")
        cell.quizImage.layer.cornerRadius = cell.quizImage.frame.height / 1.5
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "showQuiz", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showQuiz") {
            let quizController = segue.destination as! QuizViewController
            let questions:[Question] = factory.getQuestions(topic: factory.titles[myIndex])
            let currentQuiz:CurrentQuizInformation = CurrentQuizInformation(title: titleArray[myIndex], questions: questions, factory:factory)
            quizController.currentQuiz = currentQuiz
        } else if segue.identifier == "settingsPopover" {
            let settingsController = segue.destination as! SettingsViewController
            settingsController.link = factory.link
            settingsController.factory = factory
        }
    }
}

