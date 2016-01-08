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
        
        //addProgrammatically()
        
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
    
    private func addProgrammatically() {
        // 1. Initialize an instance of `CDJoystick` using the constructor:
        let joystick = CDJoystick()
        joystick.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        joystick.backgroundColor = .clearColor()
        
        // 2. Customize the joystick.
        joystick.substrateColor = .lightGrayColor()
        joystick.substrateBorderColor = .grayColor()
        joystick.substrateBorderWidth = 1.0
        joystick.stickSize = CGSize(width: 50, height: 50)
        joystick.stickColor = .darkGrayColor()
        joystick.stickBorderColor = .blackColor()
        joystick.stickBorderWidth = 2.0
        joystick.fade = 0.5
        
        // 3. Setup the tracking handler to get velocity and angle data:
        joystick.trackingHandler = { (joystickData) -> () in
            self.objectView.center.x += joystickData.velocity.x
            self.objectView.center.y += joystickData.velocity.y
        }
        
        // 4. Add the joystick to your view:
        view.addSubview(joystick)
    }
    
    @IBAction func resetButtonTapped(sender: AnyObject) {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.objectView.center = self.view.center
            self.objectView.transform = CGAffineTransformIdentity
        }
    }
    
}

