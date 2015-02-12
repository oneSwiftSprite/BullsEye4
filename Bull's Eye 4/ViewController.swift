//
//  ViewController.swift
//  Bull's Eye 4
//
//  Created by Adriana Gustavson on 2/11/15.
//  Copyright (c) 2015 Adriana Gustavson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//--variables
    
    var sliderValue: Int = 1
    var targetValue: Int = 0
    var currentScore: Int = 0
    var currentLevel: Int = 0
    var totalScore: Int = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    
//--methods
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setLevel()
        setScore()
        setSliderValue()
        generateRandomTargetNumber()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
//--methods
    
    func setScore() {
        totalScore = 0
        scoreLabel.text = "\(totalScore)"
    }
    
    func setLevel() {
        currentLevel = 1
        levelLabel.text = "\(currentLevel)"
    }
    
    func increaseLevel() {
        currentLevel += 1
        levelLabel.text = "\(currentLevel)"
    }
    
    func generateScore(bullsEye :Bool) {
        var multiplier = bullsEye ? 5 : 1
        
        currentScore = (100 * multiplier) - (abs(targetValue - sliderValue))
        totalScore += currentScore
        scoreLabel.text = "\(totalScore)"
    }
    
    func setSliderValue() {
        sliderValue = lroundf(slider.value)
    }
    
    func resetSliderValue() {
        sliderValue = 50
        slider.value = Float(sliderValue)
    }
    
    func generateRandomTargetNumber() {
        targetValue = Int(1 + arc4random_uniform(100))
        targetLabel.text = "\(targetValue)"
    }
    
    func showResults(hitBullsEye:Bool) {
        var resultsTitle: String
        var resultsButton: String
   
        if (hitBullsEye) {
            resultsTitle = "BULL'S EYE!!"
            resultsButton = "Yay!"
        } else {
            resultsTitle = "You're almost there"
            resultsButton = "Try Again"
        }
        
        let message = "The target was \(targetValue), \n You hit \(sliderValue), \n You scored \(currentScore) points"
        
        let alert = UIAlertController (
            title: resultsTitle,
            message: message,
            preferredStyle: .Alert
        )
        
        let action = UIAlertAction (
            title: resultsButton,
            style: .Default,
            handler: nil
        )
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }

    @IBAction func startOver(sender: UIButton) {
        resetSliderValue()
        setScore()
        generateRandomTargetNumber()
        setLevel()
    }
    
    @IBAction func moveSlider(slider: UISlider) {
        setSliderValue()
    }

    @IBAction func endRound(sender: UIButton) {
        var hitBullsEye = (targetValue == sliderValue)

        generateScore(hitBullsEye)
        showResults(hitBullsEye)
        increaseLevel()
        generateRandomTargetNumber()
        
    }
}




