//
//  EmailTextField.swift
//  PTNeideSimoes
//
//  Created by Nuno Nunes on 03/03/2018.
//  Copyright © 2018 Nuno Nunes. All rights reserved.
//

import UIKit

class EmailControlXib: UIView {

    @IBOutlet var emailControlXib: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lineUIView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
     func setupView(){
//        let bundle = Bundle(for: type(of: self))
        Bundle.main.loadNibNamed("EmailControlXib", owner: self, options: nil)
        addSubview(emailControlXib)
        emailControlXib.frame = self.bounds
        emailControlXib.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        UINib(nibName: "EmailControlXib", bundle: bundle).instantiate(withOwner: self, options: nil)
        addSubview(emailControlXib)
        emailControlXib.frame = self.bounds
        
    }

}
