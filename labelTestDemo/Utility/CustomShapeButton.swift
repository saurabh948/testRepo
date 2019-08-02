//
//  CustomShapeButton.swift
//  labelTestDemo
//
//  Created by PCQ184 on 01/07/19.
//  Copyright © 2019 PCQ184. All rights reserved.
//

import UIKit

@IBDesignable
class CustomShapeButton: UIButton {
    
    @IBInspectable var shapeColor: UIColor = UIColor(red:0.09, green:0.89, blue:0.65, alpha:1.00)
    
    //Gradient Colors
    @IBInspectable var gradColor1: UIColor = UIColor(red:0.09, green:0.89, blue:0.65, alpha:1.00)
    @IBInspectable var gradColor2: UIColor = UIColor(red:0.07, green:0.86, blue:0.71, alpha:1.00)
    @IBInspectable var gradColor3: UIColor = UIColor(red:0.05, green:0.84, blue:0.75, alpha:1.00)
    @IBInspectable var gradColor4: UIColor = UIColor(red:0.04, green:0.82, blue:0.79, alpha:1.00)
    @IBInspectable var gradColor5: UIColor = UIColor(red:0.02, green:0.80, blue:0.84, alpha:1.00)
    @IBInspectable var gradColor6: UIColor = UIColor(red:0.01, green:0.78, blue:0.86, alpha:1.00)
    @IBInspectable var gradColor7: UIColor = UIColor(red:0.00, green:0.77, blue:0.88, alpha:1.00)
    
    private struct Constants {
        static let lineWidth: CGFloat = 0.0
        static let halfPointShift: CGFloat = 0.5
    }
    
    private var halfWidth: CGFloat {
        return bounds.width / 2
    }
    
    private var halfHeight: CGFloat {
        return bounds.height / 2
    }
    let shapePath = UIBezierPath()
    
    override func draw(_ rect: CGRect) {
        
        let shapeWidth: CGFloat = bounds.width
        let shapeHeight: CGFloat = bounds.height
        
        //let shapePath = UIBezierPath()
        
        shapePath.lineWidth = Constants.lineWidth
        
        shapePath.move(to: CGPoint(
            x: halfWidth,
            y: 0.0))
        
        //Begin Drawing the Shape
        shapePath.addLine(to: CGPoint(
            x: shapeWidth,
            y: halfHeight/2
        ))
        
        shapePath.addLine(to: CGPoint(
            x: shapeWidth,
            y: halfHeight + halfHeight/2
        ))
        
        shapePath.addLine(to: CGPoint(
            x: halfWidth,
            y: shapeHeight
        ))
        
        shapePath.addLine(to: CGPoint(
            x: 0.0,
            y: halfHeight + halfHeight/2
        ))
        
        shapePath.addLine(to: CGPoint(
            x: 0.0,
            y: halfHeight - halfHeight/2
        ))
        
        shapePath.addLine(to: CGPoint(
            x: halfWidth,
            y: 0.0
        ))
        
        shapePath.close()
        
        //Fill
        //let fillColor = UIColor(red:0.09, green:0.89, blue:0.65, alpha:1.00)
        shapeColor.setFill()
        shapePath.fill()
        
        //Gradient Color for shape------------
        let colors = [gradColor1, gradColor2, gradColor3, gradColor4, gradColor5, gradColor6, gradColor7]
        let gradient = CAGradientLayer()
        gradient.frame = shapePath.bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0.0,y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0,y: 0.5)
        
        let shapeMask = CAShapeLayer()
        shapeMask.path = shapePath.cgPath
        gradient.mask = shapeMask
        
        self.layer.addSublayer(gradient)
        //------------------------------------
        
        //Stroke
        UIColor.black.setStroke()
        shapePath.stroke()
    }
    //Control touchable area
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let path = shapePath
        if path.contains(point) {
            return self
        } else {
            return nil
        }
    }
}

/*
 func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
 let path = PNTUtility.shared().bezierPath(forButton: self)
 if path?.contains(point) ?? false {
 return self
 } else {
 return nil
 }
 }
 */

@IBDesignable
class gradientButton: UIButton {
    //Gradient Colors
    @IBInspectable var gradColor1: UIColor = UIColor(red:0.09, green:0.89, blue:0.65, alpha:1.00)
    @IBInspectable var gradColor2: UIColor = UIColor(red:0.07, green:0.86, blue:0.71, alpha:1.00)
    @IBInspectable var gradColor3: UIColor = UIColor(red:0.05, green:0.84, blue:0.75, alpha:1.00)
    @IBInspectable var gradColor4: UIColor = UIColor(red:0.04, green:0.82, blue:0.79, alpha:1.00)
    @IBInspectable var gradColor5: UIColor = UIColor(red:0.02, green:0.80, blue:0.84, alpha:1.00)
    @IBInspectable var gradColor6: UIColor = UIColor(red:0.01, green:0.78, blue:0.86, alpha:1.00)
    @IBInspectable var gradColor7: UIColor = UIColor(red:0.00, green:0.77, blue:0.88, alpha:1.00)
    
    override func draw(_ rect: CGRect) {
        self.applyGradient(withColours: [gradColor1, gradColor2, gradColor3, gradColor4, gradColor5, gradColor6, gradColor7])
        self.setTitleColor(UIColor.white, for: .normal)
    }
}
