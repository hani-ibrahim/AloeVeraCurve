//
//  PolynomialLineCurve.swift
//  AloeVeraCurve
//
//  Created by Hani on 27.10.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit

/// Polynomial Line Curve
///
/// - Parameters:
///   - point1: point on the line
///   - point2: another point on the line
/// - Returns: A function that takes `x` and return the corresponding `y` on the line
/// - Throws:
///   - invalidParameters: if the input points have the same x positions
public func polynomialLineCurveFor(point1: CurvePoint, point2: CurvePoint) throws -> (_ x: CGFloat) -> CGFloat {
    guard point1.input != point2.input else {
        throw CurveError.invalidParameters
    }
    
    let x1 = point1.input
    let x2 = point2.input
    let y1 = point1.output
    let y2 = point2.output
    
    let m = (y2 - y1) / (x2 - x1)
    let c = y1 - m * x1
    
    return { x in
        return m * x + c
    }
}
