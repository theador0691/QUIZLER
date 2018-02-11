//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()

        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        }else {
            pickedAnswer = false
        }
        
        checkAnswer()
        nextQuestion()
        updateUI()
    }
    
    
    func updateUI() {
      questionLabel.text = allQuestions.list[questionNumber].questionText
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1) / 13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
    }
    

    func nextQuestion() {
        if questionNumber < 12 {
            questionNumber += 1
        } else{
            let alert = UIAlertController(title: "Fin", message: "You have completed the quiz", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart?", style: .default, handler: { (UIAlertAction) in
                self.startOver()
            })
            print("You finished")
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if pickedAnswer == correctAnswer {
            ProgressHUD.showSuccess("Correct!")
            score += 1
        }else {
            ProgressHUD.showError("Incorrect")        }

    }
    
    
    func startOver() {
        questionNumber = 0
        score = 0
        updateUI()

    }
    

    
}
