//
//  FunctionFile.swift
//  SoundPad
//
//  Created by Julian Silvestri on 2022-01-11.
//

import Foundation
import UIKit

func basicAlert(vc toDisplayOn: UIViewController, titleOfAlert: String, messageOfAlert: String, sender: UIButton, completionHandler: @escaping(Bool) ->Void){
    let alert = UIAlertController(title: titleOfAlert, message: messageOfAlert , preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
        switch action.style{
            case .default:
//                    print("default")
//                self.checkRecordings()
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
                completionHandler(false)
                return
            default:
                completionHandler(false)
                return
        }
    }))
    toDisplayOn.present(alert, animated: true, completion: nil)
}
