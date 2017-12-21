//
//  ChannelVC.swift
//  Smack
//
//  Created by Nuno Nunes on 19/12/2017.
//  Copyright © 2017 Nuno Nunes. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }
}
