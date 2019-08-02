//
//  UIView+Extension.swift
//  Effects
//
//  Created by PCQ184 on 02/07/19.
//  Copyright © 2019 PCQ184. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func applyGradient(withColours colours: [UIColor], locations: [NSNumber]? = nil, startPoint: CGPoint = CGPoint()) -> Void {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = CGPoint(x: 0.0,y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0,y: 0.5)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func applyGradient(withColours colours: [UIColor], gradientOrientation orientation: GradientOrientation) {
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    @IBInspectable
    var fixRadious: CGFloat{
        get {
            return 0
        }
        
        set {
            if newValue > 0  {
                self.layer.cornerRadius = newValue
                self.layer.masksToBounds = true
            }
        }
    }
}



