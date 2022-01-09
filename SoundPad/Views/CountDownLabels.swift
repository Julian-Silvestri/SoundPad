//
//  CountDownLabels.swift
//  SoundPad
//
//  Created by Julian Silvestri on 2022-01-05.
//

import UIKit

class CountDownLabels: UILabel {

    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func labelViewSetup(){
        textColor = .black
        
        text = "Recording"
    }
    
    func labelViewTearDown(){
        textColor = .black
        text = "..."

    }

}
