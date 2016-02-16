//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Liem Ly Quan on 1/30/16.
//  Copyright © 2016 Liem Ly Quan. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

  @IBOutlet weak var recordButton: UIButton! = nil
  @IBOutlet weak var recordingLabel: UILabel! = nil
  @IBOutlet weak var stopRecordButton: UIButton! = nil
  
  var audioRecorder:AVAudioRecorder!
  var recordedAudio:RecordedAudio!


  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(animated: Bool) {
    stopRecordButton.hidden = true
    recordingLabel.hidden = true
    recordButton.enabled = true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func recordAudio(sender: UIButton) {
    // TODO: Record user's voice
    recordButton.enabled = false
    recordingLabel.hidden = false
    stopRecordButton.hidden = false
    
    let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
    
    let recordingName = "my_audio.wav"

    let pathArray = [dirPath, recordingName]
    let filePath = NSURL.fileURLWithPathComponents(pathArray)
    print(filePath)
    
    let session = AVAudioSession.sharedInstance()
    try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
    
    try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
    audioRecorder.delegate = self
    audioRecorder.meteringEnabled = true
    audioRecorder.prepareToRecord()
    audioRecorder.record()
  }
  
  @IBAction func stopRecordAudio(sender: UIButton) {
    recordingLabel.hidden = true
    stopRecordButton.hidden = true
    recordButton.enabled = true
    
    audioRecorder.stop()
    let audioSession = AVAudioSession.sharedInstance()
    try! audioSession.setActive(false)
  }
  
  func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
    if (flag){
      print(1)
      recordedAudio = RecordedAudio()
      recordedAudio.filePathUrl = recorder.url
      recordedAudio.title = recorder.url.lastPathComponent
      // TODO: Move to next scene
      self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
      print(2)
    } else {
      print("Recording was not successful")
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "stopRecording"){
      let playSoundVC:PlaySoundViewController = segue.destinationViewController as! PlaySoundViewController
      let data = sender as! RecordedAudio
      playSoundVC.receivedAudio = data
      
    }
  }
}

