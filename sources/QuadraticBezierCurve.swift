//
//  QuadraticBezierCurve.swift
//  AloeVeraCurve
//
//  Created by Hani on 27.10.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit

public func quadraticBezierCurve(withStartPoint startPoint: CGPoint, controlPoint: CGPoint, endPoint: CGPoint) throws -> (_ time: CGFloat) -> CGPoint {
    guard startPoint != controlPoint && startPoint != endPoint else {
        throw CurveError.invalidParameters
    }
    
    let x1 = startPoint.x
    let x2 = controlPoint.x
    let x3 = endPoint.x
    let ax = x1 - 2 * x2 + x3
    let bx = 2 * (x2 - x1)
    let cx = x1
    
    let y1 = startPoint.y
    let y2 = controlPoint.y
    let y3 = endPoint.y
    let ay = y1 - 2 * y2 + y3
    let by = 2 * (y2 - y1)
    let cy = y1
    
    return { time in
        let x = ax * time * time + bx * time + cx
        let y = ay * time * time + by * time + cy
        return CGPoint(x: x, y: y)
    }
}
