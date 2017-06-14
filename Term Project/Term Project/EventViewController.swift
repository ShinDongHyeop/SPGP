//
//  ViewController.swift
//  Hospital_Map
//
//  Created by KPUGAME on 2017. 4. 26..
//  Copyright © 2017년 DONGHYEOP SHIN. All rights reserved.
//

import UIKit
import Speech


class EventViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private let speechRecognizer = SFSpeechRecognizer()!
    @IBAction func doneToPickerViewController22(segue: UIStoryboardSegue) {
    }
    private var speechRecognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var speechRecognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    var date = 1
    
    @IBOutlet weak var segemetControl: UISegmentedControl!
    
    @IBAction func segemetAction(_ sender: Any) {
        switch (segemetControl.selectedSegmentIndex){
        case 0:
            date = 2
            break
        case 1:
            date = 1
            break
        default:
            break;
        }
        
        
    }
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func stopTranscribing(_ sender: Any) {
        if audioEngine.isRunning{
            audioEngine.stop()
            speechRecognitionRequest?.endAudio()
            transcribeButton.isEnabled = true
            stopButton.isEnabled = false
        }
        
        switch (self.myTextView.text) {
        case "광진구" : self.pickerView.selectRow(0, inComponent: 0, animated: true)
            break
        case "구로구" : self.pickerView.selectRow(1, inComponent: 0, animated: true)
            break
        case "동대문구" : self.pickerView.selectRow(2, inComponent: 0, animated: true)
            break
        case "종로구" : self.pickerView.selectRow(3, inComponent: 0, animated: true)
            break
            
        default:
            break
        }
        
    }
    @IBAction func startTranscribing(_ sender: Any) {
        transcribeButton.isEnabled = false
        stopButton.isEnabled = true
        try! startSession()
        
        switch (self.myTextView.text) {
        case "광진구" : self.pickerView.selectRow(0, inComponent: 0, animated: true)
            break
        case "구로구" : self.pickerView.selectRow(1, inComponent: 0, animated: true)
            break
        case "동대문구" : self.pickerView.selectRow(2, inComponent: 0, animated: true)
            break
        case "종로구" : self.pickerView.selectRow(3, inComponent: 0, animated: true)
            break
            
        default:
            break
        }
        
        
    }
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var transcribeButton: UIButton!
    @IBAction func doneToPickerViewController(segue: UIStoryboardSegue) {
    }
    
    // pickerView 데이터 배열
    func startSession() throws {
        if let recognitionTask = speechRecognitionTask {
            recognitionTask.cancel()
            self.speechRecognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSessionCategoryRecord)
        
        speechRecognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = speechRecognitionRequest else { fatalError("SFSpeechAudioBufferRecognitionRequest object creation failed") }
        
        guard let inputNode = audioEngine.inputNode else { fatalError("Audio engine has no input node") }
        
        recognitionRequest.shouldReportPartialResults = true
        
        speechRecognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            
            var finished = false
            
            if let result = result {
                self.myTextView.text =
                    result.bestTranscription.formattedString
                finished = result.isFinal
            }
            
            if error != nil || finished {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.speechRecognitionRequest = nil
                self.speechRecognitionTask = nil
                
                self.transcribeButton.isEnabled = true
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            
            self.speechRecognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
    }
    
    func authorizeSR() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.transcribeButton.isEnabled = true
                    
                case .denied:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle("Speech recognition access denied by user", for: .disabled)
                    
                case .restricted:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle("Speech recognition restricted on device", for: .disabled)
                    
                case .notDetermined:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle("Speech recognition not authorized", for: .disabled)
                }
            }
        }
    }
    
    
    var pickerDataSource = ["경기도 전체","가평군","고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시","동두천시","부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시","양평군","여주시","연천군","오산시","용인시","의왕시","의정부시","이천시","파주시","평택시","포천시","하남시","화성시"]
    
    //보훈병원정보 OpenAPI 및인증키
    //디폴트시도코드 = 서울 (sidoCd=110000)
    //ServiceKey = "sea100UMmw23Xycs33F1EQnumONR%2F9ElxBLzkilU9Yr1oT4TrCot8Y2p0jyuJP72x9rG9D8CN5yuEs6AS2sAiw%3D%3D"
    var url : String = "http://openapi.gg.go.kr/PerformanceEvent?key=4f589fa06a6c405b94e4cc085acb5736&Type=xml&SIGUN_CD="
    
    var sgguCd : String = ""//디폴트시구코드 = 전체
    
    
    // pickerView 의 컴포넌트 개수 = 1
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // pickerView 의 각 컴포넌트에 대한 row의 개수 = pickerDataSource배열 원소 개수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    // pickerView의 주어진 컴포넌트/row에 대한 데이터 = pickerDataSource 배열 원소
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    // pickerView의 row 선택시 sgguCd 를 변경해서 openAPI url에 추가함
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            sgguCd = " "   // 경기도전체
        }
        else if row == 1 {
            sgguCd = "41820"   // 가평군
        }
        else if row == 2 {
            sgguCd = "41280"   // 고양시
        }
        else if row == 3 {
            sgguCd = "41290"   // 과천시
        }
        else if row == 4 {
            sgguCd = "41210"   // 광명시
        }
        else if row == 5 {
            sgguCd = "41610"   // 광주시
        }
        else if row == 6 {
            sgguCd = "41310"   // 구리시
        }
        else if row == 7 {
            sgguCd = "41410"   // 군포시
        }
        else if row == 8 {
            sgguCd = "41570"   // 김포시
        }
        else if row == 9 {
            sgguCd = "41360"   // 남양주시
        }
        else if row == 10 {
            sgguCd = "41250"   // 동두천시
        }
        else if row == 11 {
            sgguCd = "41190"   // 부천시
        }
        else if row == 12 {
            sgguCd = "41130"   // 성남시
        }
        else if row == 13 {
            sgguCd = "41110"   // 수원시
        }
        else if row == 14 {
            sgguCd = "41390"   // 시흥시
        }
        else if row == 15 {
            sgguCd = "41270"   // 안산시
        }
        else if row == 16 {
            sgguCd = "41550"   // 안성시
        }
        else if row == 17 {
            sgguCd = "41170"   // 안양시
        }
        else if row == 18 {
            sgguCd = "41630"   // 양주시
        }
        else if row == 19 {
            sgguCd = "41830"   // 양평군
        }
        else if row == 20 {
            sgguCd = "41670"   // 여주시
        }
        else if row == 21 {
            sgguCd = "41800"   // 연천군
        }
        else if row == 22 {
            sgguCd = "41370"   // 오산시
        }
        else if row == 23 {
            sgguCd = "41460"   // 용인시
        }
        else if row == 24 {
            sgguCd = "41430"   // 의왕시
        }
        else if row == 25 {
            sgguCd = "41150"   // 의정부시
        }
        else if row == 26 {
            sgguCd = "41500"   // 이천시
        }
            
        else if row == 27 {
            sgguCd = "41480"   // 파주시
        }
        else if row == 28 {
            sgguCd = "41220"   // 평택시
            
        }
        else if row == 29 {
            sgguCd = "41650"   // 포천시
        }
        else if row == 30 {
            sgguCd = "41450"   // 하남시
        }
            
        else if row == 31 {
            sgguCd = "41590"   //화성시
        }
        // 에러 삭제
        // url = url + sgguCd
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "segueToEventTableView" {
            
            if let EventTableViewController =  segue.destination as? EventTableViewController {
                EventTableViewController.url = url + sgguCd
                EventTableViewController.date = date
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizeSR()
        // Do any additional setup after loading the view, typically from a nib.
        
        // pickerView의 데이터소스와 델리게이트를 ViewController로 설정
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
