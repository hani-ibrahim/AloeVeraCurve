//
//  LinearBezierCurve.swift
//  AloeVeraCurve
//
//  Created by Hani on 27.10.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit

public func linearBezierCurve(withStartPoint startPoint: CGPoint, endPoint: CGPoint) throws -> (_ time: CGFloat) -> CGPoint {
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
    
    return { time in
        let x = ax * time + bx
        let y = ay * time + by
        return CGPoint(x: x, y: y)
    }
}
