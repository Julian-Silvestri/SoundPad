//
//  DeleteVC.swift
//  SoundPad
//
//  Created by Julian Silvestri on 2022-01-07.
//

import UIKit
import CoreData

class DeleteVC: UIViewController {
    
    var context:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    @IBAction func deleteAllRecordings(_ sender: Any) {
        let managedContext = appDelegate!.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Sounds")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let arrUsrObj = try managedContext.fetch(fetchRequest)
            for usrObj in arrUsrObj as! [NSManagedObject] {
                managedContext.delete(usrObj)
            }
           try managedContext.save() //don't forget
            } catch let error as NSError {
            print("delete fail--",error)
          }
    }

}
