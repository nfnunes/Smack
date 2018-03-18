//
//  ViewController.swift
//  topSample
//
//  Created by Nuno Nunes on 10/03/2018.
//  Copyright © 2018 Nuno Nunes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nearToTop: NSLayoutConstraint!
    @IBOutlet weak var farFromTop: NSLayoutConstraint!
    @IBOutlet weak var constraintSwitcher: UISwitch!
    @IBOutlet weak var redTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func switchChanged(_ sender: Any) {
        if constraintSwitcher.isOn{
            redTextField.isHidden = true
            nearToTop.isActive = true
            farFromTop.isActive = false
        } else {
            redTextField.isHidden = false
            nearToTop.isActive = false
            farFromTop.isActive = true
        }
    }
    
}

