//
//  UIViewMoveKeyBoard.swift
//  Reminders
//
//  Created by Robert Wais on 2/3/18.
//  Copyright © 2018 Robert Wais. All rights reserved.
//

import UIKit

extension UIView {
    func bindToKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardChanged(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)    }
    
    @objc func keyboardChanged(_ notification: NSNotification){
        //key that identifies the animations of the keyboard
        let change = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        
        //before keyboard goes up
        let frame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        
        let endingFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let delta = endingFrame.origin.y - frame.origin.y
        UIView.animateKeyframes(withDuration: change, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {self.frame.origin.y += delta
            
        }, completion: nil)
    }
}
