//
//  LineCurve.swift
//  AloeVeraCurve
//
//  Created by Hani on 27.10.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit

public func lineCurveFor(point1: CGPoint, point2: CGPoint) throws -> (CGFloat) -> CGFloat {
    guard point1.x != point2.x else {
        throw CurveError.verticalLineNotSupported
    }
    
    // Solving equation y = m * x + c
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
