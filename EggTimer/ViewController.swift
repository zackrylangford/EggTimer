//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var progressBar: UIView!
    
    @IBOutlet weak var progressBar1: UIProgressView!
    @IBOutlet weak var eggLabel: UILabel!
    var audioPlayer: AVAudioPlayer?
    
    let softTime = 5
    let mediumTime = 7
    let hardTime = 12
    
    let eggTimes : [String : Int] = ["Soft": 5, "Medium": 7, "Hard": 12]
    
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
    eggLabel.text = ("Egg is cooking!")
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        secondsPassed = 0
        progressBar1.setProgress(1.0, animated: false)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            
            let percentageProgress = Float(totalTime - secondsPassed) / Float(totalTime)
            progressBar1.setProgress(percentageProgress, animated: true)
            
        } else {
            timer.invalidate()
            print("Done!")
            eggLabel.text = ("Done!")
            playSound()
        }
    }

    func playSound() {
            guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)

                audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

                audioPlayer?.play()

            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
