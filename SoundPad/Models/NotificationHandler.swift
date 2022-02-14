//
//  NotificationHandler.swift
//  SoundPad
//
//  Created by Julian Silvestri on 2022-02-14.
//

import Foundation
import UserNotifications

class NotificationHandler{
//Permission function
func askNotificationPermission(completion: @escaping ()->Void){
    
    //Permission to send notifications
    let center = UNUserNotificationCenter.current()
    // Request permission to display alerts and play sounds.
    center.requestAuthorization(options: [.alert, .badge, .sound])
        { (granted, error) in
        // Enable or disable features based on authorization.
            completion()
        }
    }
}
