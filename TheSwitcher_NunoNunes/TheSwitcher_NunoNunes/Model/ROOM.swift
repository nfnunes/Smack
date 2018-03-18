//
//  ROOM.swift
//  TheSwitcher_NunoNunes
//
//  Created by Nuno Nunes on 09/01/2018.
//  Copyright © 2018 Nuno Nunes. All rights reserved.
//

import Foundation

class ROOM {
    private var _name: String!
    private var _light: Bool!
    
    var name: String{
        return _name
    }
    
    var light: Bool{
        return _light
    }
    
    init(name: String, light: Bool){
        
        _name = name
        _light = light

    }
    
    func changeRoomLightStatus(ligthToogle: Bool){
        _light = ligthToogle
    }
}
