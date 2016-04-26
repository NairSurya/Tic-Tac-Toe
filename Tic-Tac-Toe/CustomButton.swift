//
//  CustomButton.swift
//  Tic-Tac-Toe
//
//  Created by Surya on 25/04/16.
//  Copyright © 2016 Surya LLC. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    var value = -1
    var cross: UIImage?
    var zero: UIImage?
    required init!(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    var id = 0;
    func setID(id: Int) {
        self.id = id;
    }
    func clear() {
        value = -1
        self.setImage(nil , forState: .Normal)
    }
    func initialize() {
        cross = UIImage(named: "cross.png")
        zero = UIImage(named: "zero.png")
        
        //self.layer.cornerRadius = 15.0;
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.redColor().CGColor
        
        //Background
        self.backgroundColor = UIColor(white: 1, alpha: 0.0)
        
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        value = value == 1 ? 0 : 1
        self.setImage(value == 1 ? cross : zero, forState: UIControlState.Normal)

        
    }
}