//
//  ViewController.swift
//  iQuiz
//
//  Created by Keertana Chandar on 2/11/18.
//  Copyright © 2018 Keertana Chandar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let pictureArray:[String] = ["math", "marvel", "science", "math", "marvel", "science", "math", "marvel", "science"]
    var factory:QuizFactory = QuizFactory()
    let quests:[String:[Question]] = ["Mathematics":[Question(question:"What is 2+2?", answers:["4", "22", "An irrational number", "Nobody knows"], rightAnswer:2)], "Marvel Super Heroes":[Question(question:"Who is Iron Man?", answers:["Tony Stark", "Obadiah Stane", "A rock hit by Megadeth", "Nobody knows"], rightAnswer:2), Question(question:"Who founded the X-Men?", answers:["Tony Stark", "Professor X", "The X-Institute", "Erik Lensherr"], rightAnswer:2), Question(question:"How did Spider-Man get his powers?", answers:["He was bitten by a radioactive spider", "He ate a radioactive spider", "He is a radioactive spider", "He looked at a radioactive spider"], rightAnswer:2)], "Science!":[Question(question:"What is fire?", answers:["One of the four classical elements", "A magical reaction given to us by God", "A band that hasn't yet been discovered", "Fire! Fire! Fire! heh-heh"], rightAnswer:2)]]
    let tits:[String] = ["Science!", "Marvel Super Heroes", "Mathematics"]
    let descs:[String: String] = ["Science!": "Because SCIENCE!", "Marvel Super Heroes": "Avengers, Assemble!", "Mathematics": "Did you pass the third grade?"]
    

    
    
    var titleArray:[String] = [String]()
    var myIndex:Int = 0
    
    
    
    
    //this function is fetching the json from URL
    public func getJsonFromUrl(link:String){
        let newQuizFactory:QuizFactory = QuizFactory()
        let url = NSURL(string: link)
        let task = URLSession.shared.dataTask(with: (url as URL?)!) { (data, response, error) in
            if error != nil {
                print("Error")
                print(error as Any)
            } else {
                if let content = data {
                    do {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        for category in (myJson as? NSArray)! {
                            if let cat = category as? NSDictionary {
                                let title = cat["title"] as! String
                                let desc = cat["desc"] as! String
                                print(title)
                                print(desc)
                                newQuizFactory.addTitle(topic: title)
                                newQuizFactory.setDescription(topic: title, desc: desc)
                                let questions = cat["questions"]!
                                //self.quests[title! as! String] = questions as? [[String : Any]]
                                for quest in (questions as? NSArray)! {
                                    if let q = quest as? NSDictionary{
                                        let text = q["text"] as! String
                                        let answers = q["answers"] as! [String]
                                        let rightAnswer = Int(q["answer"] as! String)
                                        let question = Question(question: text, answers: answers, rightAnswer: rightAnswer!)
                                        print(question.question)
                                        newQuizFactory.addQuestions(topic: title, question: question)
                                    }
                                }
                            }
                        }
                    self.factory = newQuizFactory
                    } catch {
                        
                    }
                }
            }
            
        }
        task.resume()
    }


    @IBAction func settingsButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        factory.setTitles(titles: tits)
        factory.setDescriptions(descriptions: descs)
        factory.setQuestions(questions: quests)
        getJsonFromUrl(link: "http://tednewardsandbox.site44.com/questions.json")
        titleArray = factory.titles
        // Do any additional setup after loading the view, typically from a nib.
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
        cell.quizImage.image = UIImage(named: pictureArray[indexPath.row])
        cell.quizImage.layer.cornerRadius = cell.quizImage.frame.height / 1.5
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "showQuiz", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quizController = segue.destination as! QuizViewController
        let questions:[Question] = factory.getQuestions(topic: factory.titles[myIndex])
        let currentQuiz:CurrentQuizInformation = CurrentQuizInformation(title: titleArray[myIndex], questions: questions)
        quizController.currentQuiz = currentQuiz
    }
}

