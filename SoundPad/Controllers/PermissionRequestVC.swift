//
//  PermissionRequestVC.swift
//  SoundPad
//
//  Created by Julian Silvestri on 2022-02-14.
//

import UIKit
import AppTrackingTransparency
import AdSupport


class PermissionRequestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestPermission({success in
            DispatchQueue.main.async {
                if success == true {
                    self.performSegue(withIdentifier: "home", sender: self)
                } else {
                    self.performSegue(withIdentifier: "disabledPermission", sender: self)
                }
            }

        })
    }
    
    func requestPermission(_ completionHandler: @escaping(Bool?)->Void){
       //Ask for notification permission
       let n = NotificationHandler()
       n.askNotificationPermission {
           //n.scheduleAllNotifications()
           
           //IMPORTANT: wait for 1 second to display another alert
           DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
               if #available(iOS 14, *) {
                 ATTrackingManager.requestTrackingAuthorization { (status) in
                   //print("IDFA STATUS: \(status.rawValue)")
                   //FBAdSettings.setAdvertiserTrackingEnabled(true)
                     switch status {
                     case .authorized:
                         // Tracking authorization dialog was shown
                         // and we are authorized
                         print("Authorized")
                         
                         // Now that we are authorized we can get the IDFA
                         print(ASIdentifierManager.shared().advertisingIdentifier)
                         completionHandler(true)
                     case .denied:
                         // Tracking authorization dialog was
                         // shown and permission is denied
                         print("Denied")
                         completionHandler(false)
                     case .notDetermined:
                         // Tracking authorization dialog has not been shown
                         print("Not Determined")
                         completionHandler(false)
                     case .restricted:
                         print("Restricted")
                         completionHandler(false)
                     @unknown default:
                         print("Unknown")
                     }
                 }
               }
           }
       }
   }
}
