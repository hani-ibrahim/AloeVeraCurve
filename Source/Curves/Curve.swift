//
//  Curve.swift
//  AloeVeraCurve
//
//  Created by Hani on 03.11.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import Foundation

public struct Curve {
    typealias PointEvaluator = (_ time: CGFloat) -> CGPoint
    typealias LengthCalculator = (_ fromTime: CGFloat, _ toTime: CGFloat, _ precision: CGFloat) -> CGFloat
    typealias CGPathMaker = () -> CGPath
    
    let pointEvaluator: PointEvaluator
    let lengthCalculator: LengthCalculator
    let cgPathMaker: CGPathMaker
}

public extension Curve {
    func evaluatePoint(atTime time: CGFloat) -> CGPoint {
        return pointEvaluator(time)
    }
    
    func calculateLength(fromTime: CGFloat, toTime: CGFloat, withPrecision precision: CGFloat = 0.01) -> CGFloat {
        return lengthCalculator(fromTime, toTime, precision)
    }
    
    func makeCGPath() -> CGPath {
        return cgPathMaker()
    }
}
