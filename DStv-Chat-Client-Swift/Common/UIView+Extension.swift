//
//  Constraint+Helper.swift
//  DStv-Chat-Client-Swift
//
//  Created by Kudzaiishe Mhou on 2020/03/24.
//  Copyright © 2020 Kudzaiishe Mhou. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func wiggle() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.09
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y))
        self.layer.add(animation, forKey: "position")
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}

