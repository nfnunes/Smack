//
//  ListaAlunosViewController.swift
//  PTNeideSimoes
//
//  Created by Nuno Nunes on 14/03/2018.
//  Copyright © 2018 Nuno Nunes. All rights reserved.
//

import UIKit

class ListaAlunosViewController: UIViewController {

    @IBOutlet weak var menuUIButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        
//        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
//        let tap = UITapGestureRecognizer(target: self, action: #selector(ListaAlunosViewController.handleTap))
//        view.addGestureRecognizer(tap)
//        menuUIButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
//        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
    }
    


    @objc func handleTap(){
        view.endEditing(true)
    }

}
