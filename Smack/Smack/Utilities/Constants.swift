//
//  Constants.swift
//  Smack
//
//  Created by Nuno Nunes on 21/12/2017.
//  Copyright © 2017 Nuno Nunes. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// URL Constants

let BASE_URL = "https://chattychatnnn.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"

//Segues

let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"

// User Defaults

let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
