//
//  PolynomialParabolaCurve.swift
//  AloeVeraCurve
//
//  Created by Hani on 27.10.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit

/// Polynomial Parabola Curve
///
/// - Parameters:
///   - point1: point on the parabola
///   - point2: another point on the parabola
///   - point3: another point on the parabola
/// - Returns: A function that takes `x` and return the corresponding `y` on the parabola
/// - Throws:
///   - invalidParameters: if the input points have the same x positions
public func polynomialParabolaCurveFor(point1: CurvePoint, point2: CurvePoint, point3: CurvePoint) throws -> (_ x: CGFloat) -> CGFloat {
    guard point1.input != point2.input && point1.input != point3.input else {
        throw CurveError.invalidParameters
    }
    
    let x1 = point1.input
    let x2 = point2.input
    let x3 = point3.input
    let y1 = point1.output
    let y2 = point2.output
    let y3 = point3.output
    
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
