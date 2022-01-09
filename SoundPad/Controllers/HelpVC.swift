//
//  HelpVC.swift
//  SoundPad
//
//  Created by Julian Silvestri on 2021-12-25.
//

import UIKit
//import CoreData

class HelpVC: UIViewController {

    @IBOutlet weak var deleteRecordingsBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        self.deleteRecordingsBtn.layer.cornerRadius = 8
    }
    @IBAction func deleteBtnAction(_ sender: Any) {
        self.performSegue(withIdentifier: "delete", sender: self)
    }
    
}
