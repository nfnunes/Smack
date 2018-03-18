//
//  ViewController.swift
//  TheSwitcher_NunoNunes
//
//  Created by Nuno Nunes on 09/01/2018.
//  Copyright © 2018 Nuno Nunes. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var roomsTableView: UITableView!
    
    var rooms = [ROOM]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Switcher App"
        self.roomsTableView.rowHeight = 70.0
        roomsTableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        roomsTableView.delegate = self
        roomsTableView.dataSource = self
        
        rooms.append(ROOM(name: "Kitchen", light: false))
        rooms.append(ROOM(name: "Living room", light: false))
        rooms.append(ROOM(name: "Master bedroom", light: false))
        rooms.append(ROOM(name: "Guest’s bedroom", light: false))
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath) as! RoomCell
        
        let room: ROOM!
        
        room = rooms[indexPath.row]
        
        cell.roomSW.tag = indexPath.row
        cell.roomSW.addTarget(self, action: #selector(toggleLight), for: .valueChanged)
        
        cell.updateUI(room: room)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let backBtn = UIBarButtonItem()
        backBtn.title = "Back"
        backBtn.tintColor = UIColor.white
        navigationItem.backBarButtonItem = backBtn
        
        
        guard let indexPath = roomsTableView.indexPathForSelectedRow else { return }
        
        if segue.destination is RoomVC{
            let vc = segue.destination as? RoomVC
            vc?.roomName = rooms[indexPath.row].name
            vc?.roomLight = rooms[indexPath.row].light
        }
    }
    
    @objc func toggleLight(sender: UISwitch){
        sender.isOn ? rooms[sender.tag].changeRoomLightStatus(ligthToogle: true) : rooms[sender.tag].changeRoomLightStatus(ligthToogle: false)
    }
    
    
    

}
