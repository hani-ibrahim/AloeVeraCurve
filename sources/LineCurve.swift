//
//  LineCurve.swift
//  AloeVeraCurve
//
//  Created by Hani on 27.10.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit

/// Line Curve `y = m x + c`
///
/// - Parameters:
///   - point1: point on the line
///   - point2: anohter point on the line
/// - Returns: A function that takes `x` and return the corresponding `y` on the line
/// - Throws:
///   - invalidParameters: if the input points have the same x poitions
public func lineCurveFor(point1: CGPoint, point2: CGPoint) throws -> (_ x: CGFloat) -> CGFloat {
    guard point1.x != point2.x else {
        throw CurveError.invalidParameters
    }
    
    let x1 = point1.x
    let x2 = point2.x
    let y1 = point1.y
    let y2 = point2.y
    
    let m = (y2 - y1) / (x2 - x1)
    let c = y1 - m * x1
    
    return { x in
        return m * x + c
    }
}
