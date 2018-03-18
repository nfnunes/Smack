//
//  AuthService.swift
//  PTNeideSimoes
//
//  Created by Nuno Nunes on 08/03/2018.
//  Copyright © 2018 Nuno Nunes. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    func registerUser(withName name: String, andSurname surname: String, andPhone phone: String, andEmail email: String, andPassword password: String, andIsPT isPT: Bool, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ()){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                userCreationComplete(false, error)
                return
            }
            
            let userData = ["provider": user.providerID, "name": name, "surname": surname, "phone": phone, "email": user.email, "PT": isPT] as [String : Any]
            
            DataService.instance.createDBUser(uid: user.uid, userData: userData)
            userCreationComplete(true, nil)
        }
    }
    
    func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping (_ status: Bool, _ error: Error?) -> ()){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                loginComplete(false, error)
                return
            }
            loginComplete(true, nil)
            
        }
    }
    
    func logoutUser(){
        try! Auth.auth().signOut()
    }
    
    
}
