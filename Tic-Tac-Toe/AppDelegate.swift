//
//  AppDelegate.swift
//  Tic-Tac-Toe
//
//  Created by Surya on 25/04/16.
//  Copyright © 2016 Surya LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PNObjectEventListener {

    var window: UIWindow?
    var client : PubNub
    var config : PNConfiguration
    let channel: String = "com.surya.tictactoe"
    
    override init() {
        config = PNConfiguration(publishKey: "pub-c-b3cd53b4-c7f2-471a-82a4-f10d3869ff1f", subscribeKey: "sub-c-7af9a456-0b7f-11e6-a9bb-02ee2ddab7fe")
        client = PubNub.clientWithConfiguration(config)
        client.subscribeToChannels([channel], withPresence: false)
        client.publish("Swift+PubNub!", toChannel: channel, compressed: false, withCompletion: nil)
        
        super.init()
        client.addListener(self)
    }

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

