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
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
    func recordingSetup(){
        alpha = 0.9
        backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        layer.cornerRadius = 15
    }
    
    func recordingTearDown(){
        alpha = 0
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}
