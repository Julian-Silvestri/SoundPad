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
        let managedContext = appDelegate!.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Sounds")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            
            let sounds = try managedContext.fetch(fetchRequest)
            for values in sounds as! [NSManagedObject] {
                managedContext.delete(values)
            }

            try managedContext.save()
            
            basicAlert(sender: sender)
            checkRecordings()
            self.deleteAllBtn.isUserInteractionEnabled = false
            
            
            } catch let error as NSError {
            print("delete fail--",error)
          }
    }
    
    //MARK: Load Delete VC
    func loadDeleteVC(){
        fetchData()
        overrideUserInterfaceStyle = .light
        checkRecordings()

    }
    
    //MARK: Fetch Core Data
    func fetchData(){
        print("Fetching Data..")
        
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
        fetchRequest.predicate = NSPredicate(format: "recording\(sender.tag).m4a = %@", "/recording\(sender.tag).m4a")
        
        do {
            let fr = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            
            if fr!.count > 0 {
                fileFound(sender: sender)
                print("found file")
            } else {
                fileNotFound(sender: sender)
            }
            
        } catch let err {
            print(err)
        }
    }
    
    //MARK: Delete Recording from core data
    func deleteRecording(sender: UIButton){
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
                    basicAlert(sender: sender)
                }
                catch let err{
                    print(err.localizedDescription)
                }
            }
        } catch _ {
            print("Could not delete")

        }
    }
    
    func basicAlert(sender: UIButton){
        let alert = UIAlertController(title: "Deleted Item", message: "Successfully deleted item", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                    print("default")
                    self.checkRecordings()
                
                default:
                    print("error")
                
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }

    

}
