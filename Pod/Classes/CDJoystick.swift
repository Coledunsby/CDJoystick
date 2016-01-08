//
//  CDJoystick.swift
//  CDJoystickSample
//
//  Created by Cole Dunsby on 2015-12-21.
//  Copyright © 2016 Cole Dunsby. All rights reserved.
//

import UIKit

public struct CDJoystickData: CustomStringConvertible {
    public var velocity: CGPoint = .zero
    public var angle: CGFloat = 0.0
    
    public var description: String {
        return "velocity: \(velocity), angle: \(angle)"
    }
}

@IBDesignable
public class CDJoystick: UIView {

    @IBInspectable public var substrateColor: UIColor = .lightGrayColor() { didSet { setNeedsDisplay() }}
    @IBInspectable public var substrateBorderColor: UIColor = .lightGrayColor() { didSet { setNeedsDisplay() }}
    @IBInspectable public var substrateBorderWidth: CGFloat = 1.0 { didSet { setNeedsDisplay() }}
    
    @IBInspectable public var stickSize: CGSize = CGSize(width: 50, height: 50) { didSet { setNeedsDisplay() }}
    @IBInspectable public var stickColor: UIColor = .darkGrayColor() { didSet { setNeedsDisplay() }}
    @IBInspectable public var stickBorderColor: UIColor = .darkGrayColor() { didSet { setNeedsDisplay() }}
    @IBInspectable public var stickBorderWidth: CGFloat = 1.0 { didSet { setNeedsDisplay() }}
    
    @IBInspectable public var fade: CGFloat = 0.5 { didSet { setNeedsDisplay() }}
    
    public var trackingHandler: ((CDJoystickData) -> ())?
    
    private var data = CDJoystickData()
    private var stickView = UIView(frame: CGRect(origin: .zero, size: .zero))
    private var displayLink: CADisplayLink?
    
    private var tracking = false {
        didSet {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.alpha = self.tracking ? 1.0 : self.fade
            })
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {        
        displayLink = CADisplayLink(target: self, selector: "listen")
        displayLink?.addToRunLoop(.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    public func listen() {
        guard tracking else { return }
        trackingHandler?(data)
    }
    
    public override func drawRect(rect: CGRect) {
        alpha = fade
        
        layer.backgroundColor = substrateColor.CGColor
        layer.borderColor = substrateBorderColor.CGColor
        layer.borderWidth = substrateBorderWidth
        layer.cornerRadius = bounds.width / 2
        
        stickView.frame = CGRect(origin: .zero, size: stickSize)
        stickView.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        stickView.layer.backgroundColor = stickColor.CGColor
        stickView.layer.borderColor = stickBorderColor.CGColor
        stickView.layer.borderWidth = stickBorderWidth
        stickView.layer.cornerRadius = stickSize.width / 2
        
        if let superview = stickView.superview {
            superview.bringSubviewToFront(stickView)
        } else {
            addSubview(stickView)
        }
    }
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        tracking = true
        
        UIView.animateWithDuration(0.1) { () -> Void in
            self.touchesMoved(touches, withEvent: event)
        }
    }
    
    public override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInView(self)
            let distance = CGPoint(x: location.x - bounds.size.width / 2, y: location.y - bounds.size.height / 2)
            let magV = sqrt(pow(distance.x, 2) + pow(distance.y, 2))
            
            if magV <= stickView.frame.size.width {
                stickView.center = CGPoint(x: distance.x + bounds.size.width / 2, y: distance.y + bounds.size.width / 2)
            } else {
                let aX = distance.x / magV * stickView.frame.size.width
                let aY = distance.y / magV * stickView.frame.size.width
                stickView.center = CGPoint(x: aX + bounds.size.width / 2, y: aY + bounds.size.width / 2)
            }
            
            let x = clamp(distance.x, lower: -bounds.size.width / 2, upper: bounds.size.width / 2) / (bounds.size.width / 2)
            let y = clamp(distance.y, lower: -bounds.size.height / 2, upper: bounds.size.height / 2) / (bounds.size.height / 2)

            data = CDJoystickData(velocity: CGPoint(x: x, y: y), angle: -atan2(x, y))
        }
    }
    
    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        reset()
    }
    
    public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        reset()
    }
    
    private func reset() {
        tracking = false
        data = CDJoystickData()
        
        UIView.animateWithDuration(0.25) { () -> Void in
            self.stickView.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        }
    }
    
    private func clamp<T: Comparable>(value: T, lower: T, upper: T) -> T {
        return min(max(value, lower), upper)
    }
    
}
