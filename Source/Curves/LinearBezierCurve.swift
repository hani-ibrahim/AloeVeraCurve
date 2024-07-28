//
//  LinearBezierCurve.swift
//  AloeVeraCurve
//
//  Created by Hani on 27.10.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit

/// Linear Bézier Curve
///
/// - Parameters:
///   - startPoint: start point on the curve
///   - endPoint: end point on the curve
/// - Returns: `Curve`
/// - Throws:
///   - invalidParameters: if the input points are the same
public func linearBezierCurve(withStartPoint startPoint: CGPoint, endPoint: CGPoint) throws -> Curve {
    guard startPoint != endPoint else {
        throw CurveError.invalidParameters
    }
    
    let x1 = startPoint.x
    let x2 = endPoint.x
    let ax = x2 - x1
    let bx = x1
    
    let y1 = startPoint.y
    let y2 = endPoint.y
    let ay = y2 - y1
    let by = y1
    
    let pointEvaluator: (CGFloat) -> CGPoint = { time in
        let x = ax * time + bx
        let y = ay * time + by
        return CGPoint(x: x, y: y)
    }
    
    let lengthCalculator: (CGFloat, CGFloat, CGFloat) -> CGFloat = { fromTime, toTime, _ in
        return calculateLineLength(with: pointEvaluator, fromTime: fromTime, toTime: toTime)
    }
    
    let cgPathMaker: () -> CGPath = {
        let path = CGMutablePath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        return path
    }
    
    return Curve(pointEvaluator: pointEvaluator, lengthCalculator: lengthCalculator, cgPathMaker: cgPathMaker)
}
