//
//  SocketIOManager.swift
//  XYZ2
//
//  Created by Jakub on 23.04.2016.
//  Copyright © 2016 Jakub. All rights reserved.
//

import UIKit
import SocketIOClientSwift

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()
    
    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://172.20.17.14 :3000")!)
    
    
    override init() {
        super.init()
    }
    
    func establishConnection () {
        socket.connect()
        
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func sendMessage(message: String) {
        socket.emit("message", message)
    }
    
    
}
