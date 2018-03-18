//
//  RoomCell.swift
//  TheSwitcher_NunoNunes
//
//  Created by Nuno Nunes on 09/01/2018.
//  Copyright © 2018 Nuno Nunes. All rights reserved.
//

import UIKit

class RoomCell: UITableViewCell {
    
    

    @IBOutlet weak var roomLbl: UILabel!
    @IBOutlet weak var roomSW: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(room: ROOM){
        roomLbl.text = room.name
        roomSW.setOn(room.light, animated: false)
    }
    

}
