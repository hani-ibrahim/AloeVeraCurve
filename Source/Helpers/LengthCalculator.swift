//
//  LengthCalculator.swift
//  AloeVeraCurve
//
//  Created by Hani on 03.11.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import Foundation

func calculateLineLength(with pointEvaluator: Curve.PointEvaluator, fromTime: CGFloat, toTime: CGFloat) -> CGFloat {
    let p1 = pointEvaluator(fromTime)
    let p2 = pointEvaluator(toTime)
    let dy = p2.y - p1.y
    let dx = p2.x - p1.x
    return sqrt(dy * dy + dx * dx)
}

func calculateCurveLength(with pointEvaluator: Curve.PointEvaluator, fromTime: CGFloat, toTime: CGFloat, precision: CGFloat = 0.01) -> CGFloat {
    var divisions = 32
    var finalLength: CGFloat = 0
    var currentLength: CGFloat = 0
    var delta: [CGFloat] = [1, 0]
    
    repeat {
        finalLength = currentLength
        currentLength = 0
        let step = (toTime - fromTime) / CGFloat(divisions)
        
        for i in 0..<divisions {
            let iFloat = CGFloat(i)
            currentLength += calculateLineLength(with: pointEvaluator, fromTime: fromTime + step * iFloat, toTime: fromTime + step * (iFloat + 1))
        }
        
        delta.insert(abs(finalLength - currentLength), at: 0)
        divisions *= 2
    } while delta[0] > delta[1] || delta[1] > delta[2] || delta[2] > precision // Make sure when the last three iterations are close to each other
    
    return finalLength
}


