//
//  CustomView.swift
//  SoundPad
//
//  Created by Julian Silvestri on 2022-01-08.
//

import UIKit
@IBDesignable
class CustomView: UIView {
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setBg(toWhatBounds bounds: UIView){

        let colorBottom = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        let colorTop = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = bounds.bounds
        bounds.layer.insertSublayer(gradientLayer, at: 0)
//        self.view.layer.insertSublayer(gradientLayer, at:0)

    }
    
}
