//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Eduardo Hanon on 5/22/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController
{
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    override func viewDidLoad()
    {
        super.viewDidLoad()
            audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
            audioPlayer.enableRate=true
            audioEngine=AVAudioEngine()
            audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error:nil)
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func snail(sender: UIButton)
    //Plays audio slowly
        {
            playAudioWithVariableRate(0.5)
        }

    @IBAction func rabbit(sender: UIButton)
    {
        playAudioWithVariableRate(2)
    }
    
    func playAudioWithVariableRate(rate: Float)
    {
        stopAudio()
        audioPlayer.rate = rate
        audioPlayer.currentTime=0.0
        audioPlayer.play()
        
    }
    
    func stopAudio()
    {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func chipmunk(sender: UIButton)
    {
        playAudioWithVaraiblePitch(1000)
    }
    
   func playAudioWithVaraiblePitch(pitch: Float)
    {
        stopAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format:nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    
    
    @IBAction func darthvader(sender: UIButton)
    {
        playAudioWithVaraiblePitch(-1000)
    }
    
    @IBAction func Stop(sender: UIButton)
    {
        audioPlayer.stop()
        audioEngine.stop()
    }
    
}
