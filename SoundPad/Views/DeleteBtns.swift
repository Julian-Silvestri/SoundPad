//
//  DeleteBtns.swift
//  SoundPad
//
//  Created by Julian Silvestri on 2022-01-07.
//

import UIKit

@IBDesignable
class DeleteBtns: UIButton {

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        noRecordings()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        noRecordings()
    }
    
    func noRecordings(){
        titleLabel?.font = .systemFont(ofSize: 9)
        backgroundColor = #colorLiteral(red: 0.2692032158, green: 0.2544137537, blue: 0.2503143549, alpha: 1)
        setTitle("No Recording", for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        layer.cornerRadius = 8
        
        
    }
}
