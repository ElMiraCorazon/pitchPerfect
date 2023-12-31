//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Eduardo Hanon on 5/22/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate
    {
        //Declared Globally
        var audioRecorder: AVAudioRecorder!
        var recordedAudio: RecordedAudio!
    
        @IBOutlet weak var recordingInProgress: UILabel!
        @IBOutlet weak var stopButton: UIButton!
        @IBOutlet weak var recordButton: UIButton!

        override func didReceiveMemoryWarning()
        {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    override func viewWillAppear(animated: Bool)
        {
        //Hide Stop Botton
        [super.viewWillAppear(animated)]
        stopButton.hidden=true
        recordButton.enabled=true
        }

        @IBAction func recordAudio(sender: UIButton)
        {
            recordButton.enabled=false
            stopButton.hidden=false
            recordingInProgress.hidden=false
            //TODO: Record the user's voice
            
            println("in recordAudio")
            //Inside func recordAudio(sender: UIButton)
            let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as!  String
            
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
            audioRecorder.meteringEnabled = true;
            audioRecorder.record()
        }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool)
        {
          if(flag)
            {
//            recordedAudio = RecordedAudio()
//            recordedAudio.filePathUrl = recorder.url
//            recordedAudio.title = recorder.url.lastPathComponent
            var recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
            }
            else
            {
                println("Recording was not successful")
                recordButton.enabled = true
                stopButton.hidden = true
            }
        }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "stopRecording")
        {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
        @IBAction func stopRecording(sender: UIButton)
        {
            recordingInProgress.hidden=true
            audioRecorder.stop()
            var audioSession = AVAudioSession.sharedInstance();
            audioSession.setActive(false, error: nil)
        }
  
    
    }


