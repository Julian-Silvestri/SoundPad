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
        backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        setTitle("No Recording", for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        layer.cornerRadius = 8
        titleLabel?.font = UIFont(name: "Avenir", size:10)
    }
}
