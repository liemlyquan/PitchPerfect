//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Liem Ly Quan on 1/30/16.
//  Copyright © 2016 Liem Ly Quan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var recordingText: UILabel! = nil

  
  override func viewDidLoad() {
    super.viewDidLoad()
    recordingText.hidden = true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func recordAudio(sender: UIButton) {
    // TODO: Record user's voice
    recordingText.hidden = false
  }
  
  @IBAction func stopRecordAudio(sender: UIButton) {
    recordingText.hidden = true;
  }
}

