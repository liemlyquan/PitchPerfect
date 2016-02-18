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
  var audioEngine:AVAudioEngine!
  var audioFile:AVAudioFile!

  override func viewDidLoad() {
    super.viewDidLoad()
    audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
    audioPlayer.enableRate = true
    audioEngine = AVAudioEngine()
    audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
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
  @IBAction func playChipmunkAudio(sender: UIButton) {
    playAudioWithVariablePitch(1000)
  }
  @IBAction func playDarthvaderAudio(sender: UIButton) {
    playAudioWithVariablePitch(-1000)
  }
  
  func playAudioWithVariablePitch(pitch: Float){
    audioPlayer.stop()
    audioEngine.stop()
    audioEngine.reset()
    
    let audioPlayerNode = AVAudioPlayerNode()
    audioEngine.attachNode(audioPlayerNode)
    
    let changePitchEffect = AVAudioUnitTimePitch()
    changePitchEffect.pitch = pitch
    audioEngine.attachNode(changePitchEffect)
    
    audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
    audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
    
    audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
    try! audioEngine.start()
    
    audioPlayerNode.play()
  }
}
