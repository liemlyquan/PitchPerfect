//
//  PlaySoundViewController.swift
//  PitchPerfect
//
//  Created by Liem Ly Quan on 2/1/16.
//  Copyright © 2016 Liem Ly Quan. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
  var audioPlayer:AVAudioPlayer!
  var receivedAudio:RecordedAudio!

  override func viewDidLoad() {
    super.viewDidLoad()
//    if let filePath = NSBundle.mainBundle().URLForResource("movie_quote", withExtension: "mp3") {
//
//    } else {
//      print("Invalid file path")
//    }
    
    audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
    audioPlayer.enableRate = true
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
    
  @IBAction func playSlowRecord(sender: UIButton) {
    audioPlayer.stop()
    audioPlayer.rate = 0.5
    audioPlayer.play()
  }
  
  @IBAction func playFastRecord(sender: UIButton) {
    audioPlayer.stop()
    audioPlayer.rate = 2
    audioPlayer.play()
  }
}
