//
//  ViewController.swift
//  CDJoystick
//
//  Created by Cole Dunsby on 01/07/2016.
//  Copyright (c) 2016 Cole Dunsby. All rights reserved.
//

import UIKit
import CDJoystick

class ViewController: UIViewController {

    @IBOutlet private weak var joystickMove: CDJoystick!
    @IBOutlet private weak var joystickRotate: CDJoystick!
    @IBOutlet private weak var objectView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        joystickMove.trackingHandler = { (joystickData) -> () in
            //print("joystickMove data: \(joystickData)")
            
            let scale: CGFloat = 5.0
            
            self.objectView.center.x += joystickData.velocity.x * scale
            self.objectView.center.y += joystickData.velocity.y * scale
        }
        
        joystickRotate.trackingHandler = { (joystickData) -> () in
            //print("joystickRotate data: \(joystickData)")
            
            self.objectView.transform = CGAffineTransformMakeRotation(joystickData.angle)
        }
    }
    
    @IBAction func resetButtonTapped(sender: AnyObject) {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.objectView.center = self.view.center
            self.objectView.transform = CGAffineTransformIdentity
        }
    }
    
}

