//
//  RegisterViewController.swift
//  PTNeideSimoes
//
//  Created by Nuno Nunes on 04/03/2018.
//  Copyright © 2018 Nuno Nunes. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextFieldNib: NameTextFieldNib!
    @IBOutlet weak var surnameTextFieldNib: NameTextFieldNib!
    @IBOutlet weak var mobiletextFieldNib: PhoneTextFieldNib!
    @IBOutlet weak var emailTextFieldNib: EmailTextFieldNib!
    @IBOutlet weak var passwordTextFieldNib: PasswordTextFieldNib!
    @IBOutlet weak var confirmPasswordTextFieldNib: PasswordTextFieldNib!
    @IBOutlet weak var souPTUISwitch: UISwitch!
    @IBOutlet weak var codigoPTUITextField: PasswordTextFieldNib!
    @IBOutlet weak var codigoPTSpaceUIView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        self.emailTextFieldNib.emailTextField.delegate = self
        self.passwordTextFieldNib.passwordTextField.delegate = self
        self.nameTextFieldNib.nameTextField.delegate = self
        self.surnameTextFieldNib.nameTextField.delegate = self
        self.mobiletextFieldNib.phoneTextField.delegate = self
        self.confirmPasswordTextFieldNib.passwordTextField.delegate = self
        self.codigoPTUITextField.passwordTextField.delegate = self
        
        surnameTextFieldNib.nameTextField.placeholder = "Apelido"
        confirmPasswordTextFieldNib.passwordTextField.placeholder = "Confirmar Password"
        // Do any additional setup after loading the view.
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    

    @IBAction func souPTUISwitchChanged(_ sender: Any) {
        if (souPTUISwitch.isOn){
            codigoPTUITextField.isHidden = false
            codigoPTSpaceUIView.isHidden = true
        } else {
            codigoPTUITextField.isHidden = true
            codigoPTSpaceUIView.isHidden = false
        }
    }
    
    @IBAction func exitUIButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerBtnPressed(_ sender: Any) {

        guard let email = self.emailTextFieldNib.emailTextField?.text, email != "",
            let password = self.passwordTextFieldNib.passwordTextField?.text, password != "",
            let confirmPassword = self.confirmPasswordTextFieldNib.passwordTextField?.text, password != "",
            let name = self.nameTextFieldNib.nameTextField?.text, name != "",
            let surname = self.surnameTextFieldNib.nameTextField?.text, surname != ""
            else  {
                if self.emailTextFieldNib.emailTextField?.text == ""{
                    self.emailTextFieldNib.requiredLabel.isHidden = false
                    self.emailTextFieldNib.invalidEmailLabel.isHidden = true
                    self.emailTextFieldNib.usedEmailLabel.isHidden = true
                }
                if self.passwordTextFieldNib.passwordTextField?.text == ""{
                    self.passwordTextFieldNib.requiredLabel.isHidden = false
                }
                if self.confirmPasswordTextFieldNib.passwordTextField?.text == "" {
                    self.confirmPasswordTextFieldNib.requiredLabel.isHidden = false
                }
                if self.nameTextFieldNib.nameTextField?.text == ""{
                    self.nameTextFieldNib.requiredLabel.isHidden = false
                }
                if self.surnameTextFieldNib.nameTextField?.text == ""{
                    self.surnameTextFieldNib.requiredLabel.isHidden = false
                }
                return
            }
        
        guard let phone = self.mobiletextFieldNib.phoneTextField?.text else { return }
        
        if souPTUISwitch.isOn{
            if let codigo = self.codigoPTUITextField.passwordTextField.text{
                if codigo == codigoPT{
                    codigoPTUITextField.wrongCode.isHidden = true
                    registar(name: name, surname: surname, phone: phone, email: email, password: password, confirmPassword: confirmPassword)
                }
                else{
                    codigoPTUITextField.wrongCode.isHidden = false
                }
            }
            if codigoPTUITextField.passwordTextField.text == ""{
                codigoPTUITextField.wrongCode.isHidden = true
                codigoPTUITextField.requiredLabel.isHidden = false
            }
        } else {
            registar(name: name, surname: surname, phone: phone, email: email, password: password, confirmPassword: confirmPassword)
        }
    }

    
    func registar(name: String, surname: String, phone: String, email: String, password: String, confirmPassword: String){
        if password == confirmPassword{
            confirmPasswordTextFieldNib.differentPasswords.isHidden = true
            AuthService.instance.registerUser(withName: name,
                                              andSurname: surname,
                                              andPhone: phone,
                                              andEmail: email,
                                              andPassword: password,
                                              andIsPT: souPTUISwitch.isOn,
                                              userCreationComplete: { (success, registrationError) in
                                                if success{
                                                    
                                                    AuthService.instance.loginUser(withEmail: self.emailTextFieldNib.emailTextField.text!, andPassword: self.passwordTextFieldNib.passwordTextField.text!, loginComplete: { (success, nil) in
                                                        
                                                        if Auth.auth().currentUser?.isEmailVerified == false {
                                                            Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                                                                
                                                                if error == nil{
                                                                    let alert  = UIAlertController(title: "Aviso", message: "Verifique o seu email para ativar a conta", preferredStyle: .alert)
                                                                    
                                                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction) in
                                                                        let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
                                                                        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                                                                        self.present(loginViewController, animated: true, completion: nil)
                                                                    }))
                                                                    self.present(alert, animated: true, completion: nil)
                                                                    
                                                                    ////
//                                                                    let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
//                                                                    let SWRevealViewController = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController")
//                                                                    self.present(SWRevealViewController, animated: true, completion: {
//                                                                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
//                                                                    })
                                                                    /////
                                                                }
                                                            })
                                                        }
                                                    })
                                                } else {
                                                    if let errorCode = AuthErrorCode(rawValue: registrationError!._code){
                                                        switch errorCode{
                                                        case .invalidEmail:
                                                            self.emailTextFieldNib.requiredLabel.isHidden = true
                                                            self.emailTextFieldNib.invalidEmailLabel.isHidden = false
                                                            self.emailTextFieldNib.usedEmailLabel.isHidden = true
                                                        case .emailAlreadyInUse:
                                                            self.emailTextFieldNib.requiredLabel.isHidden = true
                                                            self.emailTextFieldNib.usedEmailLabel.isHidden = false
                                                            self.emailTextFieldNib.invalidEmailLabel.isHidden = true
                                                        case .weakPassword:
                                                            self.passwordTextFieldNib.shortLabel.isHidden = false
                                                        default: print(registrationError)
                                                        }
                                                    }
                                                }
            })
        } else {
            if confirmPassword == ""{
                confirmPasswordTextFieldNib.requiredLabel.isHidden = false
                confirmPasswordTextFieldNib.differentPasswords.isHidden = true
            } else {
                confirmPasswordTextFieldNib.requiredLabel.isHidden = true
                confirmPasswordTextFieldNib.differentPasswords.isHidden = false
            }
        }
    }
    
    @objc func dismissKeyboard() {
        emailTextFieldNib.emailTextField.endEditing(true)
        passwordTextFieldNib.passwordTextField.endEditing(true)
        nameTextFieldNib.nameTextField.endEditing(true)
        surnameTextFieldNib.nameTextField.endEditing(true)
        mobiletextFieldNib.phoneTextField.endEditing(true)
        confirmPasswordTextFieldNib.passwordTextField.endEditing(true)
        codigoPTUITextField.passwordTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextFieldNib.emailTextField.endEditing(true)
        passwordTextFieldNib.passwordTextField.endEditing(true)
        nameTextFieldNib.nameTextField.endEditing(true)
        surnameTextFieldNib.nameTextField.endEditing(true)
        mobiletextFieldNib.phoneTextField.endEditing(true)
        confirmPasswordTextFieldNib.passwordTextField.endEditing(true)
        codigoPTUITextField.passwordTextField.endEditing(true)
        return false
    }
    
    
    
}
