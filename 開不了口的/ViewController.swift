//
//  ViewController.swift
//  開不了口的
//
//  Created by 蔡佳穎 on 2021/5/26.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var languageSegmentedControl: UISegmentedControl!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var pitchSlider: UISlider!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var volumeValueLabel: UILabel!
    @IBOutlet weak var pitchValueLabel: UILabel!
    @IBOutlet weak var speedValueLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var talkText = ""
    var language = "zh-TW"
    var volume: Float = 0.0
    var pitch: Float = 0.0
    var speed: Float = 0.0
    let synthesizer = AVSpeechSynthesizer()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func closeKeyboard(_ sender: UITextField) {
        talkText = textField.text!
    }
    
    @IBAction func changeLanguage(_ sender: UISegmentedControl) {
        
        switch languageSegmentedControl.selectedSegmentIndex {
        case 0:
            language = "zh-TW"
        case 1:
            language = "en-US"
        case 2:
            language = "ja-JP"
        case 3:
            language = "ko-KR"
        default:
            break
        }
    }
    
    @IBAction func changeVolume(_ sender: UISlider) {
        volume = sender.value
        volumeValueLabel.text = String(format: "%.1f", volume)
        volumeValueLabel.sizeToFit()
    }
    
    @IBAction func changePitch(_ sender: UISlider) {
        pitch = sender.value
        pitchValueLabel.text = String(format: "%.1f", pitch)
        pitchValueLabel.sizeToFit()
    }
    
    @IBAction func changeSpeed(_ sender: UISlider) {
        speed = sender.value
        speedValueLabel.text = String(format: "%.1f", speed)
        speedValueLabel.sizeToFit()
    }
    
    @IBAction func speakAndPause(_ sender: UIButton) {
        
        //未按播放鈕
        if synthesizer.isSpeaking == false && button.currentTitle == "說出來" {
            button.setTitle("暫停", for: .normal)
            talkText = textField.text!
            let talk = AVSpeechUtterance(string: talkText)
            talk.voice = AVSpeechSynthesisVoice(language: language)
            talk.volume = volume
            talk.pitchMultiplier = pitch
            talk.rate = speed
            synthesizer.speak(talk)
        }
        //播放中，按暫停鈕
        else if synthesizer.isSpeaking == true && button.currentTitle == "暫停" {
            synthesizer.pauseSpeaking(at: AVSpeechBoundary.immediate)
            button.setTitle("說出來", for: .normal)
        }
        //暫停後，繼續播放
        else if synthesizer.isPaused == true && button.currentTitle == "說出來" {
            synthesizer.continueSpeaking()
            button.setTitle("暫停", for: .normal)
        }
        //播放完畢
        else if synthesizer.isSpeaking == false {
            button.setTitle("說出來", for: .normal)
        }
    }
}

