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
    
    func addMessage(messageBody: String, userId: String, channelId: String, complition: @escaping CompletionHandler){
        let user = UserDataService.instance
        
        socketManager.defaultSocket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        complition(true)
    }
    
    func getChatMessage(completion: @escaping (_ newMessage: Message) -> Void){
        socketManager.defaultSocket.on("messageCreated") { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            guard let userName = dataArray[3] as? String else { return }
            guard let userAvatar = dataArray[4] as? String else { return }
            guard let userAvatarColor = dataArray[5] as? String else { return }
            guard let id = dataArray[6] as? String else { return }
            guard let timeStamp = dataArray[7] as? String else { return }
            
            let newMessage = Message(message: msgBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
            
            completion(newMessage)
            
            
        }
        
    }
    
    func getTypingUsers(_ completionHandler: @escaping (_ typingUsers: [String:String]) -> Void){
        socketManager.defaultSocket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String: String] else { return }
            completionHandler(typingUsers)
        }
    }

}
