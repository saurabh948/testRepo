//
//  Gradient.swift
//  Effects
//
//  Created by PCQ184 on 02/07/19.
//  Copyright © 2019 PCQ184. All rights reserved.
//

import Foundation
import UIKit

typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

enum GradientOrientation {
    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical
    case topBottom
    case bottomTop
    
    var startPoint : CGPoint {
        return points.startPoint
    }
    
    var endPoint : CGPoint {
        return points.endPoint
    }
    
    var points : GradientPoints {
        get {
            switch(self) {
            case .topRightBottomLeft:
                return (CGPoint(x: 0.0,y: 1.0), CGPoint(x: 1.0,y: 0.0))
            case .topLeftBottomRight:
                return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 1,y: 1))
            case .horizontal:
                return (CGPoint(x: 0.0,y: 0.5), CGPoint(x: 1.0,y: 0.5))
            case .vertical:
                return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 0.0,y: 1.0))
            case .topBottom:
                return (CGPoint(x: 0.5, y: 0.6), CGPoint(x: 0.5,y: 1.0))
            case .bottomTop:
                return (CGPoint(x: 0.5, y: 0.0), CGPoint(x: 0.5,y: 0.4))
            }
        }
    }
}
