//
//  ParabolaCurve.swift
//  AloeVeraCurve
//
//  Created by Hani on 27.10.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit

public func parabolaCurveFor(point1: CGPoint, point2: CGPoint, point3: CGPoint) throws -> (CGFloat) -> CGFloat {
    guard point1.x != point2.x && point1.x != point3.x else {
        throw CurveError.quadraticAxisOfSymmetryIsNotVertical
    }
    
    // Solving equation y = a * x^2 + b * x + c
    let x1 = point1.x
    let x2 = point2.x
    let x3 = point3.x
    let y1 = point1.y
    let y2 = point2.y
    let y3 = point3.y
    
    let x21 = x2 - x1
    let x31 = x3 - x1
    let y21 = y2 - y1
    let y31 = y3 - y1
    
    let xx21 = x2 * x2 - x1 * x1
    let xx31 = x3 * x3 - x1 * x1
    
    let a = (y31 / x31 - y21 / x21) / (xx31/x31 - xx21 / x21)
    let b = (y21 - a * xx21) / x21
    let c = y1 - a * x1 * x1 - b * x1
    
    return { x in
        return a * x * x + b * x + c
    }
}
