//
//  PasswordTextFieldNib.swift
//  PTNeideSimoes
//
//  Created by Nuno Nunes on 04/03/2018.
//  Copyright © 2018 Nuno Nunes. All rights reserved.
//

import UIKit

@IBDesignable

class PasswordTextFieldNib: UIControl {
    
    @IBOutlet var passwordTextFieldNib: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var requiredLabel: UILabel!
    @IBOutlet weak var shortLabel: UILabel!
    @IBOutlet weak var differentPasswords: UILabel!
    @IBOutlet weak var wrongCode: UILabel!
    @IBOutlet weak var wrongPassword: UILabel!
    
    var contentView: UIView?
    //@IBInspectable var nibName: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup(){
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView?{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PasswordTextFieldNib", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }
    
    @IBAction func userPressedTextField(_ sender: Any) {
        passwordTextField.becomeFirstResponder()
        requiredLabel.isHidden = true
        differentPasswords.isHidden = true
        shortLabel.isHidden = true
        wrongPassword.isHidden = true
    }
    



}
