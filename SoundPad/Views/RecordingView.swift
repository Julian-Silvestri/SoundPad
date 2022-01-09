//
//  RecordingView.swift
//  SoundPad
//
//  Created by Julian Silvestri on 2022-01-05.
//

import UIKit

class RecordingView: UIView {
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
        
    func recordingSetup(){
        alpha = 0.9
        backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 0.8113961119)
        layer.cornerRadius = 15
    }
    
    func recordingTearDown(){
        alpha = 0
        backgroundColor = #colorLiteral(red: 0.9787157178, green: 0.9195838571, blue: 0.9075530171, alpha: 1)
    }
}
