//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by Surya on 25/04/16.
//  Copyright © 2016 Surya LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PubNubCallback {
    let chanceValue = Int(arc4random_uniform(6) + 1)
    @IBAction func onNextButtonPressed(sender: UIButton) {
        print("Next pressed")
    }
    
    let pubnubUtils = PubNubUtils()
    override func viewDidLoad() {
        super.viewDidLoad()
        pubnubUtils.setProtocol(self)
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        width = screenSize.width / 3.0
        height = width
        screenHeight = screenSize.height
        createButton()
                
        // Do any additional setup after loading the view, typically from a nib.
    }
    func onPublish() {
        for button in buttons as!: [CustomButton] {
            button.setMyValue(myVal)
        }
    }
    func onSuccess(message: String) {
        let arr = message.characters.split{$0 == " "}.map(String.init)
        
        let handshake: String = arr[0]
        let chance: Int? = Int(arr[1])
        if handshake.lowercaseString.rangeOfString("handshake") != nil {
            let myVal = self.chanceValue > chance ? 1 : 0
            for button in buttons as!: [CustomButton] {
                button.setMyValue(myVal)
            }
            
        } else {
            let id:Int? = Int(arr[0])
            let value:Int? = Int(arr[1])
            buttons[id!].setMainValue(value!)
        }

    }
    
    func onReceiveMessage(message: String) {
        print(message)
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

