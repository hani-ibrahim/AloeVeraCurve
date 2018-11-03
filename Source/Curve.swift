//
//  Curve.swift
//  AloeVeraCurve
//
//  Created by Hani on 03.11.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import Foundation

public struct Curve {
    public typealias PointEvaluator = (_ time: CGFloat) -> CGPoint
    public typealias LengthCalculator = (_ fromTime: CGFloat, _ toTime: CGFloat, _ precision: CGFloat) -> CGFloat
    public typealias CGPathMaker = () -> CGPath
    
    public let pointEvaluator: PointEvaluator
    public let lengthCalculator: LengthCalculator
    public let cgPathMaker: CGPathMaker
}
