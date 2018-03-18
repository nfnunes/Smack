//
//  ViewController.swift
//  PTNeideSimoes
//
//  Created by Nuno Nunes on 27/02/2018.
//  Copyright © 2018 Nuno Nunes. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var emailTextFieldNib: EmailTextFieldNib!
    @IBOutlet weak var loginBorderUIButton: BorderUIButton!
    @IBOutlet weak var passwordTextFieldNib: PasswordTextFieldNib!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextFieldNib.emailTextField.delegate = self
        self.passwordTextFieldNib.passwordTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        view.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func loginBtnPressed(_ sender: Any) {
        passwordTextFieldNib.shortLabel.isHidden = true
        if emailTextFieldNib.emailTextField.text != nil && passwordTextFieldNib.passwordTextField.text != nil{
            AuthService.instance.loginUser(withEmail: emailTextFieldNib.emailTextField.text!, andPassword: passwordTextFieldNib.passwordTextField.text!, loginComplete: { (success, loginError) in
                if success{
                    if Auth.auth().currentUser!.isEmailVerified{
                        let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
                        let SWRevealViewController = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController")
                        self.present(SWRevealViewController, animated: true, completion: {
                            NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        })
                    } else {
                        let alert  = UIAlertController(title: "Aviso", message: "Verifique o seu email para ativar a conta", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        alert.addAction(UIAlertAction(title: "Reenviar", style: .default, handler: { (action:UIAlertAction) in
                            Auth.auth().currentUser?.sendEmailVerification(completion: nil)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    if let errorCode = AuthErrorCode(rawValue: loginError!._code){
                        switch errorCode{
                        case .userNotFound:
                            self.emailTextFieldNib.userNotRegistered.isHidden = false
                            self.passwordTextFieldNib.wrongPassword.isHidden = true
                        case .wrongPassword:
                            self.passwordTextFieldNib.wrongPassword.isHidden = false
                            self.emailTextFieldNib.userNotRegistered.isHidden = true
                        default: print(loginError)
                        }
                    }
                }
            })
        }
    }
    

    @IBAction func registerUIButtonPressed(_ sender: Any) {
        
        if let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController{
            present(vc, animated: true, completion: nil)
        }
        
    }
    
    @objc func dismissKeyboard() {
        emailTextFieldNib.emailTextField.endEditing(true)
        passwordTextFieldNib.passwordTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextFieldNib.emailTextField.endEditing(true)
        passwordTextFieldNib.passwordTextField.endEditing(true)
        return false
    }

    
}

