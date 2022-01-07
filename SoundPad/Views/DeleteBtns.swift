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
        setupBtns()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBtns()
    }
    
    func setupBtns(){
        layer.cornerRadius = 8
        backgroundColor = #colorLiteral(red: 0.7812709212, green: 0, blue: 0, alpha: 1)
        titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        
    }

}
