//
//  CustomButton.swift
//  SoundPad
//
//  Created by Julian Silvestri on 2021-12-24.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    let textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupBtn()
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupBtn()
    }

    
    func setupBtn(){
        layer.cornerRadius = 8
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.black.cgColor
        setTitle("Record", for: .normal)
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = UIFont(name: "Avenir", size:12)
    }
    
}
