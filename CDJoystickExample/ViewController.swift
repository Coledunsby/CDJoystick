//
//  ViewController.swift
//  CDJoystickExample
//
//  Created by Cole Dunsby on 2016-01-07.
//  Copyright © 2016 Cole Dunsby. All rights reserved.
//

import UIKit

private extension ClosedRange {
    
    func clamp(_ value: Bound) -> Bound {
        return min(max(value, lowerBound), upperBound)
    }
}

final class ViewController: UIViewController {

    private let scale: CGFloat = 5.0
    
    @IBOutlet private weak var joystickMove: CDJoystick!
    @IBOutlet private weak var joystickRotate: CDJoystick!
    @IBOutlet private weak var joystickMoveLabel: UILabel!
    @IBOutlet private weak var joystickRotateLabel: UILabel!
    @IBOutlet private weak var spaceshipImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // addProgrammatically()
        
        joystickMove.trackingHandler = { [unowned self] joystickData in
            print("joystickMove data: \(joystickData)")
            
//            self.joystickMoveLabel.text = "\(joystickData)"
            self.spaceshipImageView.center.x = (0 ... self.view.frame.width).clamp(self.spaceshipImageView.center.x + joystickData.velocity.x * self.scale)
            self.spaceshipImageView.center.y = (0 ... self.view.frame.height).clamp(self.spaceshipImageView.center.y + joystickData.velocity.y * self.scale)
        }
        
        joystickRotate.trackingHandler = { [unowned self] joystickData in
            print("joystickRotate data: \(joystickData)")
            
//            self.joystickRotateLabel.text = "\(joystickData)"
            self.spaceshipImageView.transform = CGAffineTransform(rotationAngle: joystickData.angle)
        }
    }
    
    private func addProgrammatically() {
        // 1. Initialize an instance of `CDJoystick` using the constructor:
        let joystick = CDJoystick()
        joystick.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        joystick.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
        // 2. Customize the joystick.
        joystick.substrateColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
        joystick.substrateBorderColor = #colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 1)
        joystick.substrateBorderWidth = 1.0
        joystick.stickSize = CGSize(width: 50, height: 50)
        joystick.stickColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
        joystick.stickBorderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        joystick.stickBorderWidth = 2.0
        joystick.fade = 0.5
        
        // 3. Setup the tracking handler to get velocity and angle data:
        joystick.trackingHandler = { [unowned self] joystickData in
            self.spaceshipImageView.center.x = (0 ... self.view.frame.width).clamp(self.spaceshipImageView.center.x + joystickData.velocity.x * self.scale)
            self.spaceshipImageView.center.y = (0 ... self.view.frame.height).clamp(self.spaceshipImageView.center.y + joystickData.velocity.y * self.scale)
        }
        
        // 4. Add the joystick to your view:
        view.addSubview(joystick)
    }
    
    @IBAction private func resetButtonTapped(_ sender: AnyObject) {
        UIView.animate(withDuration: 0.5) {
            self.spaceshipImageView.center = self.view.center
            self.spaceshipImageView.transform = .identity
        }
    }
}
