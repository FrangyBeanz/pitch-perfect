//
//  RecordSounds.swift
//  Phil's Pitch Perfect!
//
//  Created by Phillip Hughes on 31/03/2015.
//  Copyright (c) 2015 Phillip Hughes. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSounds: UIViewController, AVAudioRecorderDelegate {
    
    
    @IBOutlet weak var RecordingText: UILabel!
    @IBOutlet weak var StopButton: UIButton!
    @IBOutlet weak var RecordAudioImage: UIButton!
    @IBOutlet weak var TapText: UILabel!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RecordingText.hidden = true
    }
    
  
    override func viewWillAppear(animated: Bool) {
        StopButton.hidden = true
        RecordAudioImage.enabled = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func RecordAudio(sender: UIButton) {
        println("in RecordAudio")
        TapText.hidden = true;
        RecordAudioImage.enabled = false;
        RecordingText.hidden = false;
        StopButton.hidden = false;
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if (flag){
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            recordedAudio.filePathUrl = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else{
            println("Recording was unsuccessful")
            RecordAudioImage.enabled = true
            StopButton.hidden = true
        }
      
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording"){
            let playSoundsVC:PlaySounds = segue.destinationViewController as PlaySounds
            let data = sender as RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
 

    @IBAction func StopButton(sender: UIButton) {
        RecordingText.hidden = true;
        TapText.hidden = false;
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance();
        audioSession.setActive(false, error: nil)
        }
    
}