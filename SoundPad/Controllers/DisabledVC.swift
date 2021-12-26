//
//  DisabledVC.swift
//  SoundPad
//
//  Created by Julian Silvestri on 2021-12-25.
//

import UIKit

class DisabledVC: UIViewController {
    @IBOutlet weak var disabledText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        overrideUserInterfaceStyle = .light
        self.navigationController?.navigationBar.topItem?.backButtonTitle = " "
        self.disabledText.text = """
        Sound pad needs access to your microphone in order to function.The application will not work so long as access to the microphone is disabled. Head over to your settings and enable microphone access in the Sound Pad Application
        """
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Disabled"
    }
    
    
}
