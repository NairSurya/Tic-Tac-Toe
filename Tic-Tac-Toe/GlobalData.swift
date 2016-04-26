//
//  GlobalData.swift
//  Tic-Tac-Toe
//
//  Created by Surya on 26/04/16.
//  Copyright © 2016 Surya LLC. All rights reserved.
//

import Foundation

protocol GlobalDataCallback {
    func onSuccessfulChange()
}

class GlobalData: NSObject {
    static let instance = GlobalData()
    
    private override init(){
        super.init()
    }
    
    var myChance: Bool? = false
    
    func setMyChance(value: Bool){
        self.myChance = value
    }

}