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
    var value = 1
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
    
    func initialize() {
        //Border
        //        self.layer.cornerRadius = 15.0;
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.redColor().CGColor
        
        //Background
        self.backgroundColor = UIColor(white: 1, alpha: 0.0)
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(value == 1){
            print ("\(id) = X")
        
        }
        else {print ("\(id) = 0")}
        
        value = value == 1 ? 0 : 1
        
    }
}