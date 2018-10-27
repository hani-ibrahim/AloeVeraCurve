//
//  CubicBezierCurve.swift
//  AloeVeraCurve
//
//  Created by Hani on 27.10.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit

/// Cubic Bézier Curve
///
/// - Parameters:
///   - startPoint: start point on the curve
///   - controlPoint1: the first control point of the curve
///   - controlPoint2: the second control point of the curve
///   - endPoint: end point on the curve
/// - Returns: A function that takes `time` (0...1) and return the corresponding `point` on the curve
/// - Throws:
///   - invalidParameters: if the input points are the same
public func cubicBezierCurve(withStartPoint startPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint, endPoint: CGPoint) throws -> (_ time: CGFloat) -> CGPoint {
    guard startPoint != controlPoint1 && startPoint != controlPoint2 && startPoint != endPoint else {
        throw CurveError.invalidParameters
    }
    
    let x1 = startPoint.x
    let x2 = controlPoint1.x
    let x3 = controlPoint2.x
    let x4 = endPoint.x
    let ax = x4 - 3 * (x3 - x2) - x1
    let bx = 3 * (x3 + x1) - 6 * x2
    let cx = 3 * (x2 - x1)
    let dx = x1
    
    let y1 = startPoint.y
    let y2 = controlPoint1.y
    let y3 = controlPoint2.y
    let y4 = endPoint.y
    let ay = y4 - 3 * (y3 - y2) - y1
    let by = 3 * (y3 + y1) - 6 * y2
    let cy = 3 * (y2 - y1)
    let dy = y1
    
    return { time in
        let x = ax * time * time * time + bx * time * time + cx * time + dx
        let y = ay * time * time * time + by * time * time + cy * time + dy
        return CGPoint(x: x, y: y)
    }
}
