//
//  GradientView.swift
//  PTNeideSimoes
//
//  Created by Nuno Nunes on 05/03/2018.
//  Copyright © 2018 Nuno Nunes. All rights reserved.
//

import UIKit

@IBDesignable

class GradientView: UIView {

    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1){
        didSet{
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.8784313725, green: 0.09803921569, blue: 0.1568627451, alpha: 1){
        didSet{
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.35, y: 0.2)
        gradientLayer.endPoint = CGPoint(x: 0.6, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

}
