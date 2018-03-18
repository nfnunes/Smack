//
//  RoomVC.swift
//  TheSwitcher_NunoNunes
//
//  Created by Nuno Nunes on 09/01/2018.
//  Copyright © 2018 Nuno Nunes. All rights reserved.
//

import UIKit

class RoomVC: UIViewController {
    
    @IBOutlet weak var roomLbl: UILabel!
    @IBOutlet weak var roomLightLbl: UILabel!
    @IBOutlet weak var lightBulbImg: UIImageView!
    
    private var _roomName: String = ""
    private var _roomLight: Bool = false
    
    var roomName: String
    {
        set
        {
            _roomName = newValue
        }
        get {
            return _roomName
        }
    }
    
    var roomLight: Bool
    {
        set
        {
            _roomLight = newValue
        }
        get {
            return _roomLight
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(_roomName)"

        SetupView()
    }

    func SetupView(){
        roomLbl.text = "Your " + "\(_roomName)" + " light is"
        
        if _roomLight{
            self.roomLightLbl.text = "ON"
            self.lightBulbImg.image = UIImage(named: "light_image_ON")
        } else {
            self.roomLightLbl.text = "OFF"
            self.lightBulbImg.image = UIImage(named: "light_image_OFF")
        }
        
    }

}
