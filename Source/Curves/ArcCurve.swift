//
//  ArcCurve.swift
//  AloeVeraCurve
//
//  Created by Hani on 27.10.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit

/// Arc Curve
///
/// - Parameters:
///   - center: center of the circle
///   - radius: radius of the circle
///   - startAngle: start angle in radian
///   - endAngle: end angle in radian
///   - clockwise: direction of the Arc
/// - Returns: `Curve`
public func arcCurve(withCenter center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) -> Curve {
    let m = endAngle - startAngle
    let c = startAngle
    let lengthCoefficient = 2 * .pi * radius * m
    
    let pointEvaluator: (CGFloat) -> CGPoint = { time in
        let angle = m * time + c
        let x = center.x + radius * cos(angle)
        let y = center.y + radius * sin(angle)
        return CGPoint(x: x, y: y)
    }
    
    let lengthCalculator: (CGFloat, CGFloat, CGFloat) -> CGFloat = { fromTime, toTime, precision in
        return lengthCoefficient * (toTime - fromTime)
    }
    
    let cgPathMaker: () -> CGPath = {
        let path = CGMutablePath()
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        return path
    }
    
    return Curve(pointEvaluator: pointEvaluator, lengthCalculator: lengthCalculator, cgPathMaker: cgPathMaker)
}
