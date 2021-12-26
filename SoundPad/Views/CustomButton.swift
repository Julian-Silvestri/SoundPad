//
//  CustomButton.swift
//  SoundPad
//
//  Created by Julian Silvestri on 2021-12-24.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    let textColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
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
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        setTitle("Record", for: .normal)
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = UIFont(name: "Avenir", size:12)
    }
    
}
