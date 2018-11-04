//
//  Curve.swift
//  AloeVeraCurve
//
//  Created by Hani on 03.11.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit

public struct Curve {
    typealias PointEvaluator = (_ time: CGFloat) -> CGPoint
    typealias LengthCalculator = (_ fromTime: CGFloat, _ toTime: CGFloat, _ precision: CGFloat) -> CGFloat
    typealias CGPathMaker = () -> CGPath
    
    let pointEvaluator: PointEvaluator
    let lengthCalculator: LengthCalculator
    let cgPathMaker: CGPathMaker
}

public extension Curve {
    /// Evaluate the CGPoint at the given time where t: 0...1
    ///
    /// - Parameter time: the time value from `0` to `1`
    /// - Returns: the point on curve at the given time
    func evaluatePoint(atTime time: CGFloat) -> CGPoint {
        return pointEvaluator(time)
    }
    
    /// Calculate length between two points on the curve where the two points defined by t: 0..1 and `fromTime < toTime`
    ///
    /// - Parameters:
    ///   - fromTime: the time (0 -> 1) used to get the start point on the curve to start calculating the length
    ///   - toTime: the time (0 -> 1) used to get the end point on the curve to end calculating the length
    ///   - precision: the required precision for the length where `precision > 0 && precision < 1`
    /// - Returns: The length in the curve between the given two points
    func calculateLength(fromTime: CGFloat, toTime: CGFloat, withPrecision precision: CGFloat = 0.01) -> CGFloat {
        return lengthCalculator(fromTime, toTime, precision)
    }
    
    /// Make CGPath object representing the whole curve that can be used to draw the curve on a CALayer
    ///
    /// - Returns: CGPath object representing the full curve
    func makeCGPath() -> CGPath {
        return cgPathMaker()
    }
}
