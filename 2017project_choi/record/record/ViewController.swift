//
//  ViewController.swift
//  record
//
//  Created by kpugame on 2017. 5. 17..
//  Copyright © 2017년 Choi JungWook. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    var audioPlayer : AVAudioPlayer?
    var audioRecorder : AVAudioRecorder?

    @IBOutlet weak var Record: UIButton!
    @IBOutlet weak var Stop: UIButton!
    @IBOutlet weak var Play: UIButton!
    
    
    @IBAction func RecordAudio(_ sender: AnyObject) {
        if audioRecorder?.isRecording == false {
            Play.isEnabled = false
            Stop.isEnabled = true
            audioRecorder?.record()
        }
    }
    
    @IBAction func StopAudio(_ sender: AnyObject) {
        Stop.isEnabled = false
        Play.isEnabled = true
        Record.isEnabled = true
        
        if audioRecorder?.isRecording == true {
            audioRecorder?.stop()
        } else {
            audioPlayer?.stop()
        }
    }
    
    @IBAction func PlayAudio(_ sender: Any) {
        if audioRecorder?.isRecording == false {
            Stop.isEnabled = true
            Record.isEnabled = false
            
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: (audioRecorder?.url)!)
                audioPlayer!.delegate = self
                audioPlayer!.prepareToPlay()
                audioPlayer!.play()
            } catch let error as NSError {
                print("audioSession error: \(error.localizedDescription)")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Play.isEnabled = false
        Stop.isEnabled = false
        
        let fileMgr = FileManager.default
        
        let dirPaths = fileMgr.urls(for: .documentDirectory,
                                    in: .userDomainMask)
        
        let soundFileURL = dirPaths[0].appendingPathComponent("sound.caf")
        
        let recordSettings =
            [AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
             AVEncoderBitRateKey: 16,
             AVNumberOfChannelsKey: 2,
             AVSampleRateKey: 44100.0] as [String : Any]
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(
                AVAudioSessionCategoryPlayAndRecord)
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
        
        do {
            try audioRecorder = AVAudioRecorder(url: soundFileURL,
                                                settings: recordSettings as [String : AnyObject])
            audioRecorder?.prepareToRecord()
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        Record.isEnabled = true
        Stop.isEnabled = false
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Audio Play Decode Error")
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    
    }

    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print("Audoi Record Encode Error")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

