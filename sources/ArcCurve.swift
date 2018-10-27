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
///   - endAngle: end andle in radian
/// - Returns: A function that takes `time` (0...1) and return the corresponding `point` on the arc
public func arcCurve(withCenter center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat) -> (_ time: CGFloat) -> CGPoint {
    let m = endAngle - startAngle
    let c = startAngle
    
    return { time in
        let angle = m * time + c
        let x = center.x + radius * cos(angle)
        let y = center.y + radius * sin(angle)
        return CGPoint(x: x, y: y)
    }
}
