//
//  BorderUIButton.swift
//  PTNeideSimoes
//
//  Created by Nuno Nunes on 27/02/2018.
//  Copyright © 2018 Nuno Nunes. All rights reserved.
//

import UIKit

@IBDesignable

class BorderUIButton: UIButton {
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        self.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
//        self.titleLabel?.font = UIFont(name: "Avenir-Black", size: 26)
//    }
    
    @IBInspectable var cornerRadius: CGFloat = 30{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 4{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = #colorLiteral(red: 0.8784313725, green: 0.09803921569, blue: 0.1568627451, alpha: 1){
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
        
        
    }
    
    


}
