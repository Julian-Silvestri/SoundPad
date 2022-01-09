//
//  ViewController.swift
//  SoundPad
//
//  Created by Julian Silvestri on 2021-12-23.
//

import UIKit
import AVFoundation
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

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
    @IBOutlet weak var btn17: CustomButton!
    @IBOutlet weak var btn18: CustomButton!
    @IBOutlet weak var btn19: CustomButton!
    @IBOutlet weak var btn20: CustomButton!
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
    @IBOutlet weak var stopRecordingBtn: UIButton!
    @IBOutlet weak var recordingView: RecordingView!
    @IBOutlet weak var countDownLbl: CountDownLabels!
    @IBOutlet weak var helpBtn: UIButton!
    
    //Vars
    var audioFileUrl:URL = URL(fileURLWithPath: " ")
    var recordingSession: AVAudioSession!
    var audioRecorder1: AVAudioRecorder!
    var audioPlayer1: AVAudioPlayer? = nil
    var audioPlayer2: AVAudioPlayer? = nil
    var audioPlayer3: AVAudioPlayer? = nil
    var audioPlayer4: AVAudioPlayer? = nil
    var audioPlayer5: AVAudioPlayer? = nil
    var audioPlayer6: AVAudioPlayer? = nil
    var audioPlayer7: AVAudioPlayer? = nil
    var audioPlayer8: AVAudioPlayer? = nil
    var audioPlayer9: AVAudioPlayer? = nil
    var audioPlayer10: AVAudioPlayer? = nil
    var audioPlayer11: AVAudioPlayer? = nil
    var audioPlayer12: AVAudioPlayer? = nil
    var audioPlayer13: AVAudioPlayer? = nil
    var audioPlayer14: AVAudioPlayer? = nil
    var audioPlayer15: AVAudioPlayer? = nil
    var audioPlayer16: AVAudioPlayer? = nil
    var audioPlayer17: AVAudioPlayer? = nil
    var audioPlayer18: AVAudioPlayer? = nil
    var audioPlayer19: AVAudioPlayer? = nil
    var audioPlayer20: AVAudioPlayer? = nil
    var context:NSManagedObjectContext!
    var coreDataRecording1 = URL(fileURLWithPath: " ")
    var coreDataSounds: [Sounds] = []
    var loadedImg: URL? = nil
    
    let playSoundBtnClr = #colorLiteral(red: 0.6, green: 0.7607843137, blue: 0.3019607843, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.recordingSession = AVAudioSession.sharedInstance()
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
        btn13.tag = 13
        btn14.tag = 14
        btn15.tag = 15
        btn16.tag = 16
        btn17.tag = 17
        btn18.tag = 18
        btn19.tag = 19
        btn20.tag = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkRecordingPrivleges()
        loadApplication()
    }
    
    //MARK: Save Core Data
    func saveData(sender: Int, fileName: String) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let sounds = Sounds(context: managedContext)
        
        switch sender {
            case 1:
                sounds.recording1 = fileName
            case 2:
                sounds.recording2 = fileName
            case 3:
                sounds.recording3 = fileName
            case 4:
                sounds.recording4 = fileName
            case 5:
                sounds.recording5 = fileName
            case 6:
                sounds.recording6 = fileName
            case 7:
                sounds.recording7 = fileName
            case 8:
                sounds.recording8 = fileName
            case 9:
                sounds.recording9 = fileName
            case 10:
                sounds.recording10 = fileName
            case 11:
                sounds.recording11 = fileName
            case 12:
                sounds.recording12 = fileName
            case 13:
                sounds.recording13 = fileName
            case 14:
                sounds.recording14 = fileName
            case 15:
                sounds.recording15 = fileName
            case 16:
                sounds.recording16 = fileName
            case 17:
                sounds.recording17 = fileName
            case 18:
                sounds.recording18 = fileName
            case 19:
                sounds.recording19 = fileName
            case 20:
                sounds.recording20 = fileName
            default:
                print("Could not save")
        }
        
//        print("Storing Data..")
        do {
            try managedContext.save()
        } catch let err{
            print("Storing data Failed \(err)")
        }
    }
    
    //MARK: Fetch Core Data
    func fetchData(){
//        print("Fetching Data..")
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        let request = NSFetchRequest<Sounds>(entityName: "Sounds")

        do {
            self.coreDataSounds = try managedContext.fetch(request)
        } catch let err{
            print("Fetching data Failed \(err)")
        }
    }
    
    //MARK: Play Audio
    func playAudio(sender: UIButton) {

        self.audioFileUrl = getAudioRecorded(sender: sender, audioNameWithExtension: "recording\(sender.tag).m4a")
        stopAllPlayers()
        
        if self.audioRecorder1 == nil {
            
            switch sender.tag {
            case 1:
//                print("trying to play audio 1")
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer1 = try AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: AVFileType.m4a.rawValue)
                    
                    
                    audioPlayer1?.delegate = self
                    audioPlayer1?.volume = 4.0
                    audioPlayer1?.prepareToPlay()
                    audioPlayer1?.play()
//                    print("PLAYING::::: \(audioFileUrl)")
               } catch let error {
                    print(error.localizedDescription)
               }
                    
            case 2:
//                print("trying to play audio 2")
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer2 = try AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: AVFileType.m4a.rawValue)
                    audioPlayer2?.delegate = self
                    audioPlayer2?.volume = 4.0
                    audioPlayer2?.prepareToPlay()
                    audioPlayer2?.play()
//                    print("PLAYING::::: \(audioFileUrl)")
               } catch let error {
                    print(error.localizedDescription)
               }
            case 3:
//                print("trying to play audio 3")
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer3 = try AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: AVFileType.m4a.rawValue)
                    audioPlayer3?.delegate = self
                    audioPlayer3?.volume = 4.0
                    audioPlayer3?.prepareToPlay()
                    audioPlayer3?.play()
//                    print("PLAYING::::: \(audioFileUrl)")
               } catch let error {
                    print(error.localizedDescription)
               }
            case 4:
//                print("trying to play audio 4")
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer4 = try AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: AVFileType.m4a.rawValue)
                    audioPlayer4?.delegate = self
                    audioPlayer4?.volume = 4.0
                    audioPlayer4?.prepareToPlay()
                    audioPlayer4?.play()
//                    print("PLAYING::::: \(audioFileUrl)")
               } catch let error {
                    print(error.localizedDescription)
               }
            case 5:
//                print("trying to play audio 5")
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer5 = try AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: AVFileType.m4a.rawValue)
                    audioPlayer5?.delegate = self
                    audioPlayer5?.volume = 4.0
                    audioPlayer5?.prepareToPlay()
                    audioPlayer5?.play()
//                    print("PLAYING::::: \(audioFileUrl)")
               } catch let error {
                    print(error.localizedDescription)
               }
            case 6:
//                print("trying to play audio 6")
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer6 = try AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: AVFileType.m4a.rawValue)
                    audioPlayer6?.delegate = self
                    audioPlayer6?.volume = 4.0
                    audioPlayer6?.prepareToPlay()
                    audioPlayer6?.play()
//                    print("PLAYING::::: \(audioFileUrl)")
               } catch let error {
                    print(error.localizedDescription)
               }
            case 7:
//                print("trying to play audio 7")
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer7 = try AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: AVFileType.m4a.rawValue)
                    audioPlayer7?.delegate = self
                    audioPlayer7?.volume = 4.0
                    audioPlayer7?.prepareToPlay()
                    audioPlayer7?.play()
//                    print("PLAYING::::: \(audioFileUrl)")
               } catch let error {
                    print(error.localizedDescription)
               }
            case 8:
//                print("trying to play audio 8")
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer8 = try AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: AVFileType.m4a.rawValue)
                    audioPlayer8?.delegate = self
                    audioPlayer8?.volume = 4.0
                    audioPlayer8?.prepareToPlay()
                    audioPlayer8?.play()
//                    print("PLAYING::::: \(audioFileUrl)")
               } catch let error {
                    print(error.localizedDescription)
               }
            case 9:
//                print("trying to play audio 9")
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer9 = try AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: AVFileType.m4a.rawValue)
                    audioPlayer9?.delegate = self
                    audioPlayer9?.volume = 4.0
                    audioPlayer9?.prepareToPlay()
                    audioPlayer9?.play()
//                    print("PLAYING::::: \(audioFileUrl)")
               } catch let error {
                    print(error.localizedDescription)
               }
            case 10:
//                print("trying to play audio 10")
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer10 = try AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: AVFileType.m4a.rawValue)
                    audioPlayer10?.delegate = self
                    audioPlayer10?.volume = 4.0
                    audioPlayer10?.prepareToPlay()
                    audioPlayer10?.play()
//                    print("PLAYING::::: \(audioFileUrl)")
               } catch let error {
                    print(error.localizedDescription)
               }
            case 11:
//                print("trying to play audio 11")
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer11 = try AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: AVFileType.m4a.rawValue)
                    audioPlayer11?.delegate = self
                    audioPlayer11?.volume = 4.0
                    audioPlayer11?.prepareToPlay()
                    audioPlayer11?.play()
//                    print("PLAYING::::: \(audioFileUrl)")
               } catch let error {
                    print(error.localizedDescription)
               }
            case 12:
//                print("trying to play audio 12")
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer12 = try AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: AVFileType.m4a.rawValue)
                    audioPlayer12?.delegate = self
                    audioPlayer12?.volume = 4.0
                    audioPlayer12?.prepareToPlay()
                    audioPlayer12?.play()
//                    print("PLAYING::::: \(audioFileUrl)")
               } catch let error {
                    print(error.localizedDescription)
               }
            case 13:
//                print("trying to play audio 13")
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer13 = try AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: AVFileType.m4a.rawValue)
                    audioPlayer13?.delegate = self
                    audioPlayer13?.volume = 4.0
                    audioPlayer13?.prepareToPlay()
                    audioPlayer13?.play()
//                    print("PLAYING::::: \(audioFileUrl)")
               } catch let error {
                    print(error.localizedDescription)
               }
            case 14:
//                print("trying to play audio 14")
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer14 = try AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: AVFileType.m4a.rawValue)
                    audioPlayer14?.delegate = self
                    audioPlayer14?.volume = 4.0
                    audioPlayer14?.prepareToPlay()
                    audioPlayer14?.play()
//                    print("PLAYING::::: \(audioFileUrl)")
               } catch let error {
                    print(error.localizedDescription)
               }
            case 15:
//                print("trying to play audio 15")
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer15 = try AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: AVFileType.m4a.rawValue)
                    audioPlayer15?.delegate = self
                    audioPlayer15?.volume = 4.0
                    audioPlayer15?.prepareToPlay()
                    audioPlayer15?.play()
//                    print("PLAYING::::: \(audioFileUrl)")
               } catch let error {
                    print(error.localizedDescription)
               }
            case 16:
//                print("trying to play audio 16")
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer16 = try AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: AVFileType.m4a.rawValue)
                    audioPlayer16?.delegate = self
                    audioPlayer16?.volume = 4.0
                    audioPlayer16?.prepareToPlay()
                    audioPlayer16?.play()
//                    print("PLAYING::::: \(audioFileUrl)")
               } catch let error {
                    print(error.localizedDescription)
               }
            case 17:
//                print("trying to play audio 17")
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer17 = try AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: AVFileType.m4a.rawValue)
                    audioPlayer17?.delegate = self
                    audioPlayer17?.volume = 4.0
                    audioPlayer17?.prepareToPlay()
                    audioPlayer17?.play()
//                    print("PLAYING::::: \(audioFileUrl)")
               } catch let error {
                    print(error.localizedDescription)
               }
            case 18:
//                print("trying to play audio 18")
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer18 = try AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: AVFileType.m4a.rawValue)
                    audioPlayer18?.delegate = self
                    audioPlayer18?.volume = 4.0
                    audioPlayer18?.prepareToPlay()
                    audioPlayer18?.play()
                    print("PLAYING::::: \(audioFileUrl)")
               } catch let error {
                    print(error.localizedDescription)
               }
            case 19:
//                print("trying to play audio 19")
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer19 = try AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: AVFileType.m4a.rawValue)
                    audioPlayer19?.delegate = self
                    audioPlayer19?.volume = 4.0
                    audioPlayer19?.prepareToPlay()
                    audioPlayer19?.play()
//                    print("PLAYING::::: \(audioFileUrl)")
               } catch let error {
                    print(error.localizedDescription)
               }
            case 20:
//                print("trying to play audio 20")
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    audioPlayer20 = try AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: AVFileType.m4a.rawValue)
                    audioPlayer20?.delegate = self
                    audioPlayer20?.volume = 4.0
                    audioPlayer20?.prepareToPlay()
                    audioPlayer20?.play()
//                    print("PLAYING::::: \(audioFileUrl)")
               } catch let error {
                    print(error.localizedDescription)
               }

            default:
                print("ERRRRRRRRRR")
            }
            
        } else {
            print("cannot play, recorder is running")
        }
    }

    
    //MARK: Setup Recorder
    func setupRecorder(){
        //self.recordBtn.addAction(, for: .touchUpInside)
        do {
            try self.recordingSession.setCategory(.playAndRecord, mode: .default)
            try self.recordingSession.setActive(true)
            self.recordingSession.requestRecordPermission() { allowed in
                DispatchQueue.main.async {
                    if allowed {
                        return
                    } else {
                        return
                    }
                }
            }
        } catch {
//            print("failure getting permission")
            return
        }
    }
    
    //MARK: Stop Recording
    @IBAction func stopRecording(_ sender: UIButton) {
        
        if audioRecorder1 == nil {
            //already stopped
            return
//            print("already stopped 1")
        } else {
//            print("Stopping recording 1")
            audioRecorder1.stop()
            audioRecorder1 = nil
            self.recordingView.recordingTearDown()
            self.countDownLbl.labelViewTearDown()
//            recordingViewTearDown()
            
        }
    }
    
    //MARK: Start Recording
    @IBAction func startRecording(_ sender: UIButton) {
        let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

        if sender.backgroundColor == playSoundBtnClr {
            playAudio(sender: sender)
        } else {
            if self.audioRecorder1 == nil {
                UIView.animate(withDuration: 0.5, animations: {
                    self.recordingView.alpha = 1
                }, completion: { _ in
                    
                    DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                        self.countDownLbl.text = "3"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            self.countDownLbl.text = "2"
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                self.countDownLbl.text = "1"
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [self] in

                                    self.recordingView.recordingSetup()
                                    self.countDownLbl.labelViewSetup()
                                    
//                                    print("should be recordign")
                                    let audioFilename = documentDirURL.appendingPathComponent("recording\(sender.tag).m4a")
                                    self.audioFileUrl = documentDirURL.appendingPathComponent("recording\(sender.tag).m4a")
                
                                    let settings = [
                                        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                                        AVSampleRateKey: 12000,
                                        AVNumberOfChannelsKey: 1,
                                        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                                    ]
                                    
                                    self.audioRecorder1 = AVAudioRecorder()

                                    do {
                                        try self.recordingSession.setCategory(.record, mode: .default)
                                        try self.recordingSession.setActive(true)
                                        self.audioRecorder1 = try AVAudioRecorder(url: audioFilename, settings: settings)
                                        self.audioRecorder1.delegate = self
//                                        print("recording now....")
                                        self.audioRecorder1.prepareToRecord()
                                        self.audioRecorder1.record()
                                        
                                        //openDatabse(fileName: "/recording\(sender.tag).m4a") //saves audio file to core data
                                        saveData(sender: sender.tag, fileName: "/recording\(sender.tag).m4a")
                                        
                                        sender.backgroundColor = playSoundBtnClr
                                        sender.setTitle("Play", for: .normal)
                                        sender.setTitleColor(UIColor.black, for: .normal)
                                        
                                    } catch _ {
//                                        print("Error recording \(err)")
                                        return
                                    }
                                })
                            })
                        })
                    })
                })
            } else {
                return
//                print("ERROR -> Had to stop recording (startRecording, ibaciton)")
            }
        }
    }
    
    //MARK: Get Documents Directory
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    //MARK: Get Audio Recorded File Path
    func getAudioRecorded(sender: UIButton, audioNameWithExtension: String) -> URL{
        // getting URL path for audio
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docDir = dirPath[0]
        let soundFilePath = (docDir as NSString).appendingPathComponent(audioNameWithExtension)
        let soundFileURL = NSURL(fileURLWithPath: soundFilePath)
//        print(soundFilePath)
        return soundFileURL as URL

    }
    
    //MARK: Load APP
    func loadApplication() {
        fetchData()
        self.helpBtn.layer.cornerRadius = 8
        self.audioPlayer1 = AVAudioPlayer()
        self.audioPlayer2 = AVAudioPlayer()
        self.audioPlayer3 = AVAudioPlayer()
        self.audioPlayer4 = AVAudioPlayer()
        self.audioPlayer5 = AVAudioPlayer()
        self.audioPlayer6 = AVAudioPlayer()
        self.audioPlayer7 = AVAudioPlayer()
        self.audioPlayer8 = AVAudioPlayer()
        self.audioPlayer9 = AVAudioPlayer()
        self.audioPlayer10 = AVAudioPlayer()
        self.audioPlayer11 = AVAudioPlayer()
        self.audioPlayer12 = AVAudioPlayer()
        self.audioPlayer13 = AVAudioPlayer()
        self.audioPlayer14 = AVAudioPlayer()
        self.audioPlayer15 = AVAudioPlayer()
        self.audioPlayer16 = AVAudioPlayer()
        self.audioPlayer17 = AVAudioPlayer()
        self.audioPlayer18 = AVAudioPlayer()
        self.audioPlayer19 = AVAudioPlayer()
        self.audioPlayer20 = AVAudioPlayer()
        
        self.audioRecorder1 = AVAudioRecorder()
        self.helpBtn.layer.cornerRadius = 8
        self.stopRecordingBtn.layer.cornerRadius = 8

        self.title = "Sound Pad"
        
        self.helpBtn.layer.cornerRadius = 8
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        } else {
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        }
    
        checkAttribute(sender: self.btn1)
        checkAttribute(sender: self.btn2)
        checkAttribute(sender: self.btn3)
        checkAttribute(sender: self.btn4)
        checkAttribute(sender: self.btn5)
        checkAttribute(sender: self.btn6)
        checkAttribute(sender: self.btn7)
        checkAttribute(sender: self.btn8)
        checkAttribute(sender: self.btn9)
        checkAttribute(sender: self.btn10)
        checkAttribute(sender: self.btn11)
        checkAttribute(sender: self.btn12)
        checkAttribute(sender: self.btn13)
        checkAttribute(sender: self.btn14)
        checkAttribute(sender: self.btn15)
        checkAttribute(sender: self.btn16)
        checkAttribute(sender: self.btn17)
        checkAttribute(sender: self.btn18)
        checkAttribute(sender: self.btn19)
        checkAttribute(sender: self.btn20)
        
    }

    //MARK: Check Attr
    func checkAttribute(sender:UIButton) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Sounds")
        fetchRequest.predicate = NSPredicate(format: "recording\(sender.tag) = %@", "/recording\(sender.tag).m4a")
        
        do {
            let fr = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            
            if fr!.count > 0 {
                sender.backgroundColor = playSoundBtnClr
                sender.setTitle("Play", for: .normal)
            } else {
                sender.backgroundColor = UIColor.white
                sender.setTitle("Record", for: .normal)
            }
            
        } catch let err {
            print(err)
        }
    }
    
    //MARK: Check Recording Privl
    func checkRecordingPrivleges(){
        recordingSession.requestRecordPermission() { allowed in
            DispatchQueue.main.async { [self] in
                if allowed {
                    //allowed
//                    print("allowed to record")
                    self.view.isUserInteractionEnabled = true
                } else {
//                    print("not allowed to record")
                    self.view.isUserInteractionEnabled = false
                    self.performSegue(withIdentifier: "disabled", sender: self)
                }
            }
        }
    }

    //MARK: Stop All Players
    func stopAllPlayers(){
        audioPlayer1?.stop()
        audioPlayer2?.stop()
        audioPlayer3?.stop()
        audioPlayer4?.stop()
        audioPlayer5?.stop()
        audioPlayer6?.stop()
        audioPlayer7?.stop()
        audioPlayer8?.stop()
        audioPlayer9?.stop()
        audioPlayer10?.stop()
        audioPlayer11?.stop()
        audioPlayer12?.stop()
        audioPlayer13?.stop()
        audioPlayer14?.stop()
        audioPlayer15?.stop()
        audioPlayer16?.stop()
        audioPlayer17?.stop()
        audioPlayer18?.stop()
        audioPlayer19?.stop()
        audioPlayer20?.stop()
    }
    
    @IBAction func helpBtnAction(_ sender: Any) {
        self.performSegue(withIdentifier: "help", sender: self)
    }

}
//
//extension UIView {
//
//    func addGradient(colors: [UIColor] = [#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)], locations: [NSNumber] = [0, 2], startPoint: CGPoint = CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0), type: CAGradientLayerType = .axial){
//
//        let gradient = CAGradientLayer()
//
//        gradient.frame.size = self.frame.size
//        gradient.frame.origin = CGPoint(x: 0.0, y: 0.0)
//
//        gradient.colors = colors.map{ $0.cgColor }
//
//        gradient.locations = locations
//        gradient.startPoint = startPoint
//        gradient.endPoint = endPoint
//
//        self.layer.insertSublayer(gradient, at: 0)
//    }
//}
