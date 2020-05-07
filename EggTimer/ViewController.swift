//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {
	let eggTimes: [String: Float] = ["Soft": 300, "Medium": 420, "Hard": 720]
	var targetTime: Float = 0
	var elapsedTime: Float = 0
	var timer = Timer()
	var audioPlayer: AVAudioPlayer!
	
	@IBOutlet weak var progressBar: UIProgressView!
	@IBOutlet weak var message: UILabel!
	
	@IBAction func hardnessSelected(_ sender: UIButton) {
		timer.invalidate()
		progressBar.progress = 0
		message.text = "Cooking..."
		let hardness = sender.currentTitle!
		targetTime = eggTimes[hardness]!
		elapsedTime = 0
		timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
	}
	
	@objc func timerAction() {
		elapsedTime += 1
		progressBar.progress = elapsedTime / targetTime
		if (elapsedTime == targetTime) {
			timer.invalidate()
			soundAlarm()
			message.text = "Done!"
		}
	}
	
	func soundAlarm() {
		let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
		audioPlayer = try! AVAudioPlayer(contentsOf:url!)
		audioPlayer.play()
	}
}
