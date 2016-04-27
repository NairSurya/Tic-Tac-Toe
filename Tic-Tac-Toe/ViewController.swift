//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by Surya on 25/04/16.
//  Copyright © 2016 Surya LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PubNubCallback {
    var chanceValue: Int = 0
    var timer: NSTimer?
    func newRandom() {
        chanceValue = Int(arc4random_uniform(100) + 1)
    }
    
    @IBAction func onNextButtonPressed(sender: UIButton) {
        print("Next pressed")
        
        for button in buttons {
            button.clear()
        }
        restart()
        GlobalData.instance.setMyChance(false)
    }
    
    let pubnubUtils = PubNubUtils()
    override func viewDidLoad() {
        super.viewDidLoad()
        newRandom()
        pubnubUtils.setProtocol(self)
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        width = screenSize.width / 3.0
        height = width
        screenHeight = screenSize.height
        createButton()
        
    }
    
    func restart(){
        if timer != nil {
            timer?.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("sendHandShake"), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    func sendHandShake() {
        pubnubUtils.publish("handshake \(chanceValue) \(GlobalData.macID)")
    }
    
    func onSuccess(message: String) {
        let arr = message.characters.split{$0 == " "}.map(String.init)
        
        let handshake: String = arr[0]
        let chance: Int? = Int(arr[1])

        if handshake.lowercaseString.rangeOfString("handshake") != nil {
            let macID1: Int? = Int(arr[2])
            if(macID1 != GlobalData.macID) {
                while (chance == chanceValue) {
                    newRandom()
                }
            
                let myValueCrossOrZero = self.chanceValue > chance ? 1 : 0
                GlobalData.instance.setMyChance(myValueCrossOrZero == 1)
            
                for button in buttons {
                    button.setMyValue(myValueCrossOrZero)
                }
            
                timer?.invalidate()
            }
            
        } else {
            let id:Int? = Int(arr[0])
            let value:Int? = Int(arr[1])
            let isMyChance: Int? = Int(arr[2])
            let macID1: Int? = Int(arr[3])
            if(macID1 !=  GlobalData.macID) {
                buttons[id!].setMainValue(value!)
                GlobalData.instance.setMyChance(isMyChance == 1)
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet var mainView: UIView!
    var buttons = [CustomButton]()
    var screenHeight:CGFloat = 0
    var width: CGFloat = 0
    var height: CGFloat = 0

    func createButton() {
        var id = 0
        let diff: CGFloat = (screenHeight - 3 * height)/3.0
        func createLocalButton(positionX: CGFloat, positionY: CGFloat) {
            let button = CustomButton(frame: CGRectMake(positionX, positionY, width, height))
            mainView.addSubview(button)
            buttons.append(button);
            button.setID(id)
            button.setPubNub(pubnubUtils);
            id++
        }
        for i in 0...2 {
            let index = CGFloat(i)
            createLocalButton(index * width, positionY: diff + 0.0);
        }
        for i in 0...2 {
            let index = CGFloat(i)
            createLocalButton(index * width, positionY: diff + height);
        }
        for i in 0...2 {
            let index = CGFloat(i)
            createLocalButton(index * width, positionY: diff + (height * 2));
        }
    }

}

