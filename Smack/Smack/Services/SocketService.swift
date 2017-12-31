//
//  SocketService.swift
//  Smack
//
//  Created by Nuno Nunes on 31/12/2017.
//  Copyright © 2017 Nuno Nunes. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    
    static let instance = SocketService()
    
    var socketManager: SocketManager
    
    override init() {
        socketManager = SocketManager(socketURL: URL(string: BASE_URL)!)
        super.init()
    }
    
    func establishConnection(){
        socketManager.defaultSocket.connect()
    }
    
    func closeConnection(){
        socketManager.defaultSocket.disconnect()
    }
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler){
        socketManager.defaultSocket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler){
        socketManager.defaultSocket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDescription = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDescription, id: channelId)
            
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }

}
