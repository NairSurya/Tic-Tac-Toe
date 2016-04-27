//
//  PubNubCallback.swift
//  Tic-Tac-Toe
//
//  Created by Surya on 26/04/16.
//  Copyright © 2016 Surya LLC. All rights reserved.
//

import Foundation

protocol PubNubCallback {
    func onSuccess(message: String)
}