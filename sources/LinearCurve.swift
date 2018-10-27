//
//  LinearCurve.swift
//  AloeVeraCurve
//
//  Created by Hani on 27.10.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit

public func linearCurveFor(point1: CGPoint, point2: CGPoint) throws -> (CGFloat) -> CGFloat {
    guard point1 != point2 else {
        throw CurveError.invalidParameters
    }
    
    let x1 = point1.x
    let x2 = point2.x
    let y1 = point1.y
    let y2 = point2.y
    
    // Check if the line is vertical
    guard x1 != x2 else {
        throw CurveError.verticalLineNotSupported
    }
    
    // Check if the line is horizontal
    guard y1 != y2 else {
        return { x in
            return y1
        }
    }
    
    // Solving equation y = m * x + c
    let m = (y2 - y1) / (x2 - x1)
    let c = y1 - m * x1
    
    return { x in
        return m * x + c
    }
}
