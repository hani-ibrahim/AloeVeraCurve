//
//  LengthCalculator.swift
//  AloeVeraCurve
//
//  Created by Hani on 03.11.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import Foundation

func caluclateLineLength(with pointEvaluator: Curve.PointEvaluator, fromTime: CGFloat, toTime: CGFloat) -> CGFloat {
    let p1 = pointEvaluator(fromTime)
    let p2 = pointEvaluator(toTime)
    let dy = p2.y - p1.y
    let dx = p2.x - p1.x
//    print("fromTime: \(fromTime), toTime: \(toTime)")
    return sqrt(dy * dy + dx * dx)
}

func calculateCurveLength(with pointEvaluator: Curve.PointEvaluator, fromTime: CGFloat, toTime: CGFloat, precision: CGFloat = 0.01) -> CGFloat {
    var divisions = 1
    var finalLength: CGFloat = 0
    var currentLength: CGFloat = 0
    var delta: [CGFloat] = [1, 0]
    var iteration = 1
    let startDate = Date()
    repeat {
        finalLength = currentLength
        currentLength = 0
//        print("\n\nIteration: \(iteration)")
        let step = (toTime - fromTime) / CGFloat(divisions)
        for i in 0..<divisions {
            let iFloat = CGFloat(i)
            currentLength += caluclateLineLength(with: pointEvaluator, fromTime: fromTime + step * iFloat, toTime: fromTime + step * (iFloat + 1))
        }
//        print("currentLength: \(currentLength)")
        delta.insert(abs(finalLength - currentLength), at: 0)
        divisions *= 2
        iteration += 1
        
    } while abs(delta[2] - delta[1]) > precision && abs(delta[1] - delta[0]) > precision
//    print("delta: \(delta)")
    print("Time: \(Date().timeIntervalSince(startDate))")
    return finalLength
}


