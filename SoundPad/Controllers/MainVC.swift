//
//  ViewController.swift
//  SoundPad
//
//  Created by Julian Silvestri on 2021-12-23.
//

import UIKit
import AVFoundation

class Main: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    //CUSTOM BTNS
    @IBOutlet weak var btn1: CustomButton!
    @IBOutlet weak var btn2: CustomButton!
    @IBOutlet weak var btn3: CustomButton!
    @IBOutlet weak var btn4: CustomButton!
    @IBOutlet weak var btn5: CustomButton!
    @IBOutlet weak var btn6: CustomButton!
    @IBOutlet weak var btn7: CustomButton!
    @IBOutlet weak var btn8: CustomButton!
    @IBOutlet weak var btn9: CustomButton!
    @IBOutlet weak var btn10: CustomButton!
    @IBOutlet weak var btn11: CustomButton!
    @IBOutlet weak var btn12: CustomButton!
    @IBOutlet weak var btn13: CustomButton!
    @IBOutlet weak var btn14: CustomButton!
    @IBOutlet weak var btn15: CustomButton!
    @IBOutlet weak var btn16: CustomButton!
    //END -- Custom Btns
    
    //StackViews
    // Header Stack (Horizontal)
    @IBOutlet weak var headerStackView: UIStackView!
    // Outer Stack (vertical)
    // -- Inner Stack 2 (horizontal)
    // -- Inner Stack 3 (horizontal)
    // -- Inner Stack 4 (horizontal)
    // -- Inner Stack 5 (horizontal)
    @IBOutlet weak var outerStack: UIStackView!
    @IBOutlet weak var innerStack1: UIStackView!
    @IBOutlet weak var innerStack2: UIStackView!
    @IBOutlet weak var innerStack3: UIStackView!
    @IBOutlet weak var innerStack4: UIStackView!
    @IBOutlet weak var innerStack5: UIStackView!
    
    
    @IBOutlet weak var countDownLbl: UILabel!
    @IBOutlet weak var helpBtn: UIButton!
    
    //Vars
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer? = nil
    var loadedImg: URL? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadApplication()
//        setupDisplay()
        btn1.tag = 1
        btn2.tag = 2
        btn3.tag = 3
        btn4.tag = 4
        btn5.tag = 5
        btn6.tag = 6
        btn7.tag = 7
        btn8.tag = 8
        btn9.tag = 9
        btn10.tag = 10
        btn11.tag = 11
        btn12.tag = 12


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkRecordingPrivleges()
    }
     
    //MARK: play your recorded audio
    @IBAction func playAudio(sender: UIButton) {
        print("trying to play audio")

        if self.audioRecorder == nil {
            
            let audioFileUrl = getAudioRecorded(audioNameWithExtension: "recording\(sender.tag).m4a")
            
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                audioPlayer = try AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: AVFileType.mp3.rawValue)
                audioPlayer?.delegate = self
                audioPlayer?.volume = 4.0
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                print("PLAYING::::: \(audioFileUrl)")
           } catch let error {
                print(error.localizedDescription)
           }
            
        } else{
            print("cant play audio, recorder is running")
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        //recordBtn.isEnabled = true
        //stopBtn.isEnabled = false
    }

    @IBAction func testSave(_ sender: UIButton) {
        
        print("tring to save")
        
        let fileManager = FileManager.default
        do {
            //let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:true)
            let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = paths.appendingPathComponent("png")
            let image = #imageLiteral(resourceName: "looperLogo")
            print("almost there")
            if let imageData = image.pngData() {
                try imageData.write(to: fileURL)
                print("saved image \(fileURL)")
                self.loadedImg = fileURL
                return
            }
        } catch {
            print(error)
        }
        
    }
    private func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        print("Audio Play Decode Error")
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    }

    private func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!) {
        print("Audio Record Encode Error")
    }
    

    func setupRecorder(){
        //self.recordBtn.addAction(, for: .touchUpInside)
        do {
            try self.recordingSession.setCategory(.playAndRecord, mode: .default)
            try self.recordingSession.setActive(true)
            self.recordingSession.requestRecordPermission() { allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print("success recording")
                    } else {
                        print("failed to record")
                    }
                }
            }
        } catch {
            print("failure getting permission")
        }
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        
        if audioRecorder == nil {
            //already stopped
            print("already stopped")
        } else {
            print("Stopping recording")
            audioRecorder.stop()
            audioRecorder = nil
        }

    }
    //MARK: Finish Recording
    func finishRecording(success: Bool) {

    }
    
    //MARK: Start Recording
    @IBAction func startRecording(_ sender: UIButton) {
        
        if self.audioRecorder == nil {

            UIView.animate(withDuration: 0.4, animations: {
                self.countDownLbl.alpha = 1
            }, completion: {_ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.countDownLbl.text = "3"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.countDownLbl.text = "2"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            self.countDownLbl.text = "1"
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                self.countDownLbl.text = "Recording"
                            })
                        })
                    })
                }
                
            })
            
            
            let audioFilename = self.getDocumentsDirectory().appendingPathComponent("recording\(sender.tag).m4a")
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            self.audioRecorder = AVAudioRecorder()

            do {
                self.audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
                self.audioRecorder.delegate = self
                print("recording now....")
                self.audioRecorder.prepareToRecord()
                self.audioRecorder.record()
            } catch {
                self.finishRecording(success: false)
            }
            
        } else {
            print("ERROR -> Had to stop recording (startRecording, ibaciton)")
            self.finishRecording(success: true)
        }

    }
    
    func removeAudioFile(fileNameWithExtension: String, completionHandler: @escaping(Bool)->Void){
        
        let filemanager = FileManager.default
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0] as NSString
        let destinationPath = documentsPath.appendingPathComponent(fileNameWithExtension)

        if destinationPath.isEmpty{
            return
        } else {
            do {
                try filemanager.removeItem(atPath: destinationPath)
                print("Local path removed successfully")
                completionHandler(true)
            } catch let error as NSError {
                print("------Error removing local path",error.debugDescription)
                completionHandler(false)
            }
        }
    }
    
    //MARK: Get Documents Directory
    func getDocumentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder) {
    }

    func getAudioRecorded(audioNameWithExtension: String) -> URL{
        // getting URL path for audio
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docDir = dirPath[0]
        let soundFilePath = (docDir as NSString).appendingPathComponent(audioNameWithExtension)
        let soundFileURL = NSURL(fileURLWithPath: soundFilePath)
        print(soundFilePath)
        return soundFileURL as URL

    }
    
//    func getImgUrl() -> UIImage{
//        // getting URL path for audio
//        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
////        let docDir = dirPath[0]
////        let soundFilePath = (docDir as NSString).appendingPathComponent("png.png")
////        let soundFileURL = NSURL(fileURLWithPath: soundFilePath)
////        print(soundFilePath)
////        return soundFileURL as URL
//        var img = UIImage()
//
//        if let path = dirPath.first{
//
//            let imageURL = URL(fileURLWithPath: path).appendingPathComponent("png.png")
//            img = UIImage(contentsOfFile: imageURL.path)!
//
//
//           // Do whatever you want with the image
//        }
//        return img
//
//    }
    
    func loadApplication() {
        self.audioPlayer = AVAudioPlayer()
        self.audioRecorder = AVAudioRecorder()
        overrideUserInterfaceStyle = .light
        self.recordingSession = AVAudioSession.sharedInstance()
        self.title = "Sound Pad"
        self.helpBtn.layer.cornerRadius = 8
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        } else {
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        }
//        checkRecordingPrivleges()
    }
    
    func checkRecordingPrivleges(){
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { allowed in
                DispatchQueue.main.async { [self] in
                    if allowed {
                        //allowed
                        print("allowed to record")
                        self.view.isUserInteractionEnabled = true
                    } else {
                        print("not allowed to record")
                        self.view.isUserInteractionEnabled = false
                        self.performSegue(withIdentifier: "disabled", sender: self)
                    }
                }
            }
        } catch {
            // failed to record!
            print("error recording")
        }
    }
    
    @IBAction func helpBtnAction(_ sender: Any) {
        self.performSegue(withIdentifier: "help", sender: self)
    }
}

