//
//  QuadraticBezierCurve.swift
//  AloeVeraCurve
//
//  Created by Hani on 27.10.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit

/// Quadratic Bézier Curve
///
/// - Parameters:
///   - startPoint: start point on the curve
///   - controlPoint: the control point of the curve
///   - endPoint: end point on the curve
/// - Returns: A function that takes `time` (0...1) and return the corresponding `point` on the curve
/// - Throws:
///   - invalidParameters: if the input points are the same
public func quadraticBezierCurve(withStartPoint startPoint: CGPoint, controlPoint: CGPoint, endPoint: CGPoint) throws -> (_ time: CGFloat) -> CGPoint {
    guard startPoint != controlPoint && startPoint != endPoint else {
        throw CurveError.invalidParameters
    }
    
    let x1 = startPoint.x
    let x2 = controlPoint.x
    let x3 = endPoint.x
    let ax = x3 - 2 * x2 + x1
    let bx = 2 * (x2 - x1)
    let cx = x1
    
    let y1 = startPoint.y
    let y2 = controlPoint.y
    let y3 = endPoint.y
    let ay = y3 - 2 * y2 + y1
    let by = 2 * (y2 - y1)
    let cy = y1
    
    return { time in
        let x = ax * time * time + bx * time + cx
        let y = ay * time * time + by * time + cy
        return CGPoint(x: x, y: y)
    }
}
