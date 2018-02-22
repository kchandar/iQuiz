//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by Keertana Chandar on 2/21/18.
//  Copyright © 2018 Keertana Chandar. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    var link:String = "http://tednewardsandbox.site44.com/questions.json"
    var tempLink:String = "http://tednewardsandbox.site44.com/questions.json"
    var didWorkString:String = ""
    var didWork:Bool = true
    var factory:QuizFactory = QuizFactory()
    var tempFactory:QuizFactory = QuizFactory()
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var jsonWorkedLabel: UILabel!
    
    @IBAction func doneButton(_ sender: UIButton) {
        if(didWork && NetworkCheck.isConnectedToNetwork()) {
            if(didWorkString == "") {
                performSegue(withIdentifier: "goHomeCancel", sender: self)
            } else {
                performSegue(withIdentifier: "goHomeDone", sender: self)
            }
        } else {
            performSegue(withIdentifier: "goHomeCancel", sender: self)
        }
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goHomeCancel", sender: self)
    }
    
    
    @IBAction func checkNowButton(_ sender: UIButton) {
        jsonWorkedLabel.text = didWorkString
        let connection:Bool = NetworkCheck.isConnectedToNetwork()
        if(connection) {
            self.getJsonFromUrl(link: self.tempLink)
        } else {
            didWork = false
            jsonWorkedLabel.text = "Network Connection Failed"
        }
    }
    
    @IBAction func checkLinkWhileEditing(_ sender: UITextField) {
        self.tempLink = sender.text!
        self.getJsonFromUrl(link: self.tempLink)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(link)
        tempLink = link
        jsonWorkedLabel.text = didWorkString
        textField.text = link
        if !NetworkCheck.isConnectedToNetwork() {
            print("no network")
            let alert = UIAlertController(title: "ERROR", message: "No Network Connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let controller = segue.destination as! ViewController
        if segue.identifier == "goHomeDone" {
            controller.link = tempLink
            controller.tempFactory = tempFactory
        } else if segue.identifier == "goHomeCancel" {
            controller.link = link
            controller.tempFactory = factory
        }
    }
    
    //this function is fetching the json from URL
    private func getJsonFromUrl(link:String) {
        if !NetworkCheck.isConnectedToNetwork() {
            self.didWorkString = "Network Connection Failed"
            self.didWork = false
        } else {
            let newQuizFactory:QuizFactory = QuizFactory()
            newQuizFactory.link = link
            let url = NSURL(string: link)
            let task = URLSession.shared.dataTask(with: (url as URL?)!) { (data, response, error) in
                if error != nil {
                    self.didWorkString = "Download Failed"
                    self.didWork = false
                    print("Error")
                    print(error as Any)
                } else {
                    if let content = data {
                        do {
                            let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            print(myJson)
                            for category in (myJson as? NSArray)! {
                                if let cat = category as? NSDictionary {
                                    let title = cat["title"] as! String
                                    let desc = cat["desc"] as! String
                                    newQuizFactory.addTitle(topic: title)
                                    newQuizFactory.setDescription(topic: title, desc: desc)
                                    let questions = cat["questions"]!
                                    for quest in (questions as? NSArray)! {
                                        if let q = quest as? NSDictionary{
                                            let text = q["text"] as! String
                                            let answers = q["answers"] as! [String]
                                            let rightAnswer = Int(q["answer"] as! String)
                                            let question = Question(question: text, answers: answers, rightAnswer: rightAnswer!)
                                            newQuizFactory.addQuestions(topic: title, question: question)
                                        }
                                    }
                                }
                            }
                            self.tempFactory = newQuizFactory
                            self.didWorkString = "Success!"
                            self.didWork = true
                        } catch {
                            self.didWorkString = "Download Failed"
                            self.didWork = false
                        }
                    }
                }
                
            }
            task.resume()
        }
    }


}
