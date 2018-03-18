//
//  EmailTextFieldNib.swift
//  PTNeideSimoes
//
//  Created by Nuno Nunes on 03/03/2018.
//  Copyright © 2018 Nuno Nunes. All rights reserved.
//

import UIKit

@IBDesignable

class EmailTextFieldNib: UIControl{
    
    @IBOutlet var emailTextFieldNib: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var requiredLabel: UILabel!
    @IBOutlet weak var invalidEmailLabel: UILabel!
    @IBOutlet weak var usedEmailLabel: UILabel!
    @IBOutlet weak var userNotRegistered: UILabel!
    
    
    
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
        let nib = UINib(nibName: "EmailTextFieldNib", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }
    
    func isValidEmail(email: String) -> Bool{
        return false
    }
    
    @IBAction func userPressedTextField(_ sender: Any) {
        requiredLabel.isHidden = true
        userNotRegistered.isHidden = true
    }
    
    @IBAction func userEndEditing(_ sender: Any) {
        guard let text = emailTextField?.text, text != "" else {
            requiredLabel.isHidden = false
            return
        }
        if !text.isEmpty{
            requiredLabel.isHidden = true
        }
    }
    


}
