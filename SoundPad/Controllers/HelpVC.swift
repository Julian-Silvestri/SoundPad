//
//  HelpVC.swift
//  SoundPad
//
//  Created by Julian Silvestri on 2021-12-25.
//

import UIKit
//import CoreData

class HelpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
    }
    @IBAction func deleteBtnAction(_ sender: Any) {
        self.performSegue(withIdentifier: "delete", sender: self)
    }
    
}
