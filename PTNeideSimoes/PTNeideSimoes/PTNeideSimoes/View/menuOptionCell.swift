//
//  menuOptionCell.swift
//  PTNeideSimoes
//
//  Created by Nuno Nunes on 05/03/2018.
//  Copyright © 2018 Nuno Nunes. All rights reserved.
//

import UIKit

class menuOptionCell: UITableViewCell {

    @IBOutlet weak var menuOptionTitle: UILabel!
    
    @IBOutlet weak var menuOptionLine: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(option: String){
        let title = option
        menuOptionTitle.text = title
    }

}
