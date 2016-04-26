//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by Surya on 25/04/16.
//  Copyright © 2016 Surya LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func onNextButtonPressed(sender: UIButton) {
        print("Next pressed")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        width = screenSize.width / 3.0
        height = width
        screenHeight = screenSize.height
        createButton()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
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

