//
//  DeleteVC.swift
//  SoundPad
//
//  Created by Julian Silvestri on 2022-01-07.
//

import UIKit
import CoreData

class DeleteVC: UIViewController {
    
    @IBOutlet weak var btn1: DeleteBtns!
    @IBOutlet weak var btn2: DeleteBtns!
    @IBOutlet weak var btn3: DeleteBtns!
    @IBOutlet weak var btn4: DeleteBtns!
    @IBOutlet weak var btn5: DeleteBtns!
    @IBOutlet weak var btn6: DeleteBtns!
    @IBOutlet weak var btn7: DeleteBtns!
    @IBOutlet weak var btn8: DeleteBtns!
    @IBOutlet weak var btn9: DeleteBtns!
    @IBOutlet weak var btn10: DeleteBtns!
    @IBOutlet weak var btn11: DeleteBtns!
    @IBOutlet weak var btn12: DeleteBtns!
    @IBOutlet weak var btn13: DeleteBtns!
    @IBOutlet weak var btn14: DeleteBtns!
    @IBOutlet weak var btn15: DeleteBtns!
    @IBOutlet weak var btn16: DeleteBtns!
    @IBOutlet weak var btn17: DeleteBtns!
    @IBOutlet weak var btn18: DeleteBtns!
    @IBOutlet weak var btn19: DeleteBtns!
    @IBOutlet weak var btn20: DeleteBtns!
    
    @IBOutlet weak var deleteAllBtn: UIButton!
    var context:NSManagedObjectContext!
    
    var coreDataSounds: [Sounds] = []
    
    var btnArr: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.deleteAllBtn.backgroundColor = #colorLiteral(red: 0.7812709212, green: 0, blue: 0, alpha: 1)
        self.btn1.tag = 1
        self.btn2.tag = 2
        self.btn3.tag = 3
        self.btn4.tag = 4
        self.btn5.tag = 5
        self.btn6.tag = 6
        self.btn7.tag = 7
        self.btn8.tag = 8
        self.btn9.tag = 9
        self.btn10.tag = 10
        self.btn11.tag = 11
        self.btn12.tag = 12
        self.btn13.tag = 13
        self.btn14.tag = 14
        self.btn15.tag = 15
        self.btn16.tag = 16
        self.btn17.tag = 17
        self.btn18.tag = 18
        self.btn19.tag = 19
        self.btn20.tag = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDeleteVC()
    }
    
    @IBAction func deleteSpecificAttr(_ sender: UIButton){
        deleteRecording(sender: sender)
    }
    
    //MARK: Delete All Recordings
    @IBAction func deleteAllRecordings(_ sender: UIButton) {
        
        basicAlert(sender: sender, completionHandler: { [self]finished in
            if finished == true {
                let managedContext = appDelegate!.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Sounds")
                fetchRequest.returnsObjectsAsFaults = false
                do {
                    
                    let sounds = try managedContext.fetch(fetchRequest)
                    for values in sounds as! [NSManagedObject] {
                        managedContext.delete(values)
                    }

                    try managedContext.save()

                    checkRecordings()
                    self.deleteAllBtn.isUserInteractionEnabled = false
                    
                    } catch let error as NSError {
                        print("delete fail--",error)
                  }
            } else {
                return
            }
        })
    }
    
    //MARK: Load Delete VC
    func loadDeleteVC(){
        fetchData()
        self.deleteAllBtn.layer.cornerRadius = 8
        overrideUserInterfaceStyle = .light
        checkRecordings()

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
    
    func fileFound(sender: UIButton){
        sender.backgroundColor = #colorLiteral(red: 0.7812709212, green: 0, blue: 0, alpha: 1)
        sender.setTitle("Delete \(sender.tag)", for: .normal)
        sender.isUserInteractionEnabled = true
        self.deleteAllBtn.isUserInteractionEnabled = true
    }
    
    func fileNotFound(sender: UIButton){
        sender.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        sender.setTitle("No Recording", for: .normal)
        sender.isUserInteractionEnabled = false
    }
    
    func checkRecordings(){
        let rec1 = checkAttribute(sender: self.btn1)
        let rec2 = checkAttribute(sender: self.btn2)
        let rec3 = checkAttribute(sender: self.btn3)
        let rec4 = checkAttribute(sender: self.btn4)
        let rec5 = checkAttribute(sender: self.btn5)
        let rec6 = checkAttribute(sender: self.btn6)
        let rec7 = checkAttribute(sender: self.btn7)
        let rec8 = checkAttribute(sender: self.btn8)
        let rec9 =  checkAttribute(sender: self.btn9)
        let rec10 = checkAttribute(sender: self.btn10)
        let rec11 = checkAttribute(sender: self.btn11)
        let rec12 =  checkAttribute(sender: self.btn12)
        let rec13 = checkAttribute(sender: self.btn13)
        let rec14 = checkAttribute(sender: self.btn14)
        let rec15 = checkAttribute(sender: self.btn15)
        let rec16 = checkAttribute(sender: self.btn16)
        let rec17 = checkAttribute(sender: self.btn17)
        let rec18 = checkAttribute(sender: self.btn18)
        let rec19 = checkAttribute(sender: self.btn19)
        let rec20 = checkAttribute(sender: self.btn20)
        
        if rec1 + rec2 + rec3 + rec4 + rec5 + rec6 + rec7 + rec8 + rec9 + rec10 + rec11 + rec12 + rec13 + rec14 + rec15 + rec16 + rec17 + rec18 + rec19 + rec20 > 0{
            self.enableBtns()
        } else {
            self.disableBtns()
        }
        
    }
    
    //MARK: Check Attr
    func checkAttribute(sender:UIButton) -> Int {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return 0
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Sounds")
        fetchRequest.predicate = NSPredicate(format: "recording\(sender.tag) = %@", "/recording\(sender.tag).m4a")
        
        do {
            let fr = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            
            if fr!.count > 0 {
                fileFound(sender: sender)
                return 1
            } else {
                fileNotFound(sender: sender)
                return 0
            }
            
        } catch let err {
            print(err)
        }
        return 0
    }
    
    //MARK: Delete Recording from core data
    func deleteRecording(sender: UIButton){
    
        basicAlert(sender: sender, completionHandler: {finished in
            if finished == true {
                guard let managedContext = appDelegate?.persistentContainer.viewContext else {
                    return
                }
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Sounds")
                fetchRequest.predicate = NSPredicate(format: "recording\(sender.tag) = %@", "/recording\(sender.tag).m4a")

                do {
                    let fetchedResults =  try managedContext.fetch(fetchRequest) as? [NSManagedObject]

                    for entity in fetchedResults! {
                        
                        managedContext.delete(entity)
                        
                        do {
                            try managedContext.save()
                            
                        }
                        catch let err{
                            print(err.localizedDescription)
                        }
                    }
                    
                    self.checkRecordings()
                    
                } catch _ {
        //            print("Could not delete")
                    return
                }
            } else {
                return
            }
        })
        

    }
    
    func basicAlert(sender: UIButton, completionHandler: @escaping(Bool) ->Void){
        let alert = UIAlertController(title: "Are You Sure?", message: "Do you want to delete?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            switch action.style{
                case .default:
//                    print("default")
                    self.checkRecordings()
                    completionHandler(true)
                default:
                    return
//                    print("error")
                
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {action in
            switch action.style{
                case .default:
                    completionHandler(false)
                    return
                case .cancel:
                    return
                default:
                    return
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func enableBtns(){
        self.btn1.isUserInteractionEnabled = true
        self.btn2.isUserInteractionEnabled = true
        self.btn3.isUserInteractionEnabled = true
        self.btn4.isUserInteractionEnabled = true
        self.btn5.isUserInteractionEnabled = true
        self.btn6.isUserInteractionEnabled = true
        self.btn7.isUserInteractionEnabled = true
        self.btn8.isUserInteractionEnabled = true
        self.btn9.isUserInteractionEnabled = true
        self.btn10.isUserInteractionEnabled = true
        self.btn11.isUserInteractionEnabled = true
        self.btn12.isUserInteractionEnabled = true
        self.btn13.isUserInteractionEnabled = true
        self.btn14.isUserInteractionEnabled = true
        self.btn15.isUserInteractionEnabled = true
        self.btn16.isUserInteractionEnabled = true
        self.btn17.isUserInteractionEnabled = true
        self.btn18.isUserInteractionEnabled = true
        self.btn19.isUserInteractionEnabled = true
        self.btn20.isUserInteractionEnabled = true
        self.deleteAllBtn.isUserInteractionEnabled = true
    }
    func disableBtns() {
        self.deleteAllBtn.isUserInteractionEnabled = false
        self.btn1.isUserInteractionEnabled = false
        self.btn2.isUserInteractionEnabled = false
        self.btn3.isUserInteractionEnabled = false
        self.btn4.isUserInteractionEnabled = false
        self.btn5.isUserInteractionEnabled = false
        self.btn6.isUserInteractionEnabled = false
        self.btn7.isUserInteractionEnabled = false
        self.btn8.isUserInteractionEnabled = false
        self.btn9.isUserInteractionEnabled = false
        self.btn10.isUserInteractionEnabled = false
        self.btn11.isUserInteractionEnabled = false
        self.btn12.isUserInteractionEnabled = false
        self.btn13.isUserInteractionEnabled = false
        self.btn14.isUserInteractionEnabled = false
        self.btn15.isUserInteractionEnabled = false
        self.btn16.isUserInteractionEnabled = false
        self.btn17.isUserInteractionEnabled = false
        self.btn18.isUserInteractionEnabled = false
        self.btn19.isUserInteractionEnabled = false
        self.btn20.isUserInteractionEnabled = false
    }
    

}
