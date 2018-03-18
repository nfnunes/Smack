//
//  PhoneTextFieldNib.swift
//  PTNeideSimoes
//
//  Created by Nuno Nunes on 04/03/2018.
//  Copyright © 2018 Nuno Nunes. All rights reserved.
//

import UIKit

@IBDesignable

class PhoneTextFieldNib: UIControl {

    @IBOutlet var phoneTextFieldNib: UIView!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var invalidMobile: UILabel!
    
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
        let nib = UINib(nibName: "PhoneTextFieldNib", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }
    
    func validateMobilePhone(value: String) -> Bool {
        let PHONE_REGEX = "^9\\d{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES[c] %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    @IBAction func verifyPhone(_ sender: Any) {
        guard let phone = phoneTextField?.text, phone != "" else { return }
        if (!validateMobilePhone(value: phone)){
            invalidMobile.isHidden = false
        }
    }
    
    @IBAction func userPressedMobile(_ sender: Any) {
        invalidMobile.isHidden = true
        phoneTextField.becomeFirstResponder()
    }
    
    
}
