//
//  DataService.swift
//  PTNeideSimoes
//
//  Created by Nuno Nunes on 08/03/2018.
//  Copyright © 2018 Nuno Nunes. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    
    var REF_BASE: DatabaseReference{
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference{
        return _REF_USERS
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>){
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func getCurrentUserName(handler: @escaping (_ name: String) -> ()){
        let userID = Auth.auth().currentUser?.uid
        REF_USERS.child(userID!).observeSingleEvent(of: .value) { (snapshot) in
        let value = snapshot.value as? NSDictionary
        let name = value? ["name"] as? String ?? ""
            handler(name)
        }
    }
    

    
}
