//
//  PubNubUtils.swift
//  Tic-Tac-Toe
//
//  Created by Surya on 26/04/16.
//  Copyright © 2016 Surya LLC. All rights reserved.
//

import Foundation

class PubNubUtils: NSObject, PNObjectEventListener {
    var client : PubNub
    var config : PNConfiguration
    let channel: String = "com.surya.tictactoe"
    
    override init() {
        config = PNConfiguration(publishKey: "pub-c-b3cd53b4-c7f2-471a-82a4-f10d3869ff1f", subscribeKey: "sub-c-7af9a456-0b7f-11e6-a9bb-02ee2ddab7fe")
        client = PubNub.clientWithConfiguration(config)
        client.subscribeToChannels([channel], withPresence: false)
        super.init()
        client.addListener(self)
    }
    
    var myCallback: PubNubCallback?
    
    func setProtocol(myCallback: PubNubCallback){
        self.myCallback = myCallback
    }

    func publish(message: String){
        client.publish(message, toChannel: channel, compressed: false, withCompletion: nil)
    }
    
    func client(client: PubNub, didReceiveMessage message: PNMessageResult) {
        if(myCallback != nil) {
            myCallback?.onSuccess(message.data.message! as! String)
        }
    }
    

}
