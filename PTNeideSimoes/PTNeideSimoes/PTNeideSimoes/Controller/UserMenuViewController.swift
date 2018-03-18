//
//  UserMenuViewController.swift
//  PTNeideSimoes
//
//  Created by Nuno Nunes on 04/03/2018.
//  Copyright © 2018 Nuno Nunes. All rights reserved.
//

import UIKit
import Firebase

class UserMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuOptionsTableView: UITableView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var currentUser: String = Auth.auth().currentUser!.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuOptionsTableView.delegate = self
        menuOptionsTableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(UserMenuViewController.setupDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = menuOptionsTableView.dequeueReusableCell(withIdentifier: "menuOptionCell", for: indexPath) as? menuOptionCell{
            let option = ptMenuOptionsArray[indexPath.row]
            cell.configureCell(option: option)
            if indexPath.row == ptMenuOptionsArray.count-1{
                cell.menuOptionLine.isHidden = true
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ptMenuOptionsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let storyboard = UIStoryboard(name: "ListaAlunos", bundle: Bundle.main)
            let ListaAlunosViewController = storyboard.instantiateViewController(withIdentifier: "ListaAlunosViewController")
            present(ListaAlunosViewController, animated: true, completion: nil)
        }
    }

    @IBAction func logoutBtnPressed(_ sender: Any) {
        AuthService.instance.logoutUser()
        let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
        let LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        present(LoginViewController, animated: true, completion: nil)
    }
    
    @objc func setupDataDidChange(_ notif: Notification) {
        setupUserInfo()
    }
    
    func setupUserInfo(){
        var name = ""
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil{
                DataService.instance.getCurrentUserName(handler: { (returnedName) in
                    name = returnedName
                    self.welcomeLabel.text = "Olá \(name)"
                })
                
                
            } else {
                self.welcomeLabel.text = ""
            }
        }
    }
    
    
    
}
