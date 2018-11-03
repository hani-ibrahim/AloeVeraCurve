//
//  LengthCalculatorTests.swift
//  AloeVeraCurveTests
//
//  Created by Hani on 03.11.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import XCTest
@testable import AloeVeraCurve

final class LengthCalculatorTests: XCTestCase {

    func testCalculateLineLength() {
        let pointEvaluator: Curve.PointEvaluator = { time in
            return CGPoint(x: time, y: time * 2)
        }
        
        let totalLength = caluclateLineLength(with: pointEvaluator, fromTime: 0, toTime: 1)
        XCTAssertEqual(totalLength, sqrt(5))
        
        let halfLength = caluclateLineLength(with: pointEvaluator, fromTime: 0, toTime: 0.5)
        XCTAssertEqual(halfLength, sqrt(5) / 2)
    }
    
    func testCalculateCurveLengthWithLinearCurve() {
        let pointEvaluator: Curve.PointEvaluator = { time in
            return CGPoint(x: time, y: time * 2)
        }
        
        let precision: CGFloat = 0.01
        
        let totalLength = calculateCurveLength(with: pointEvaluator, fromTime: 0, toTime: 1, precision: precision)
        XCTAssertLessThan(abs(totalLength - sqrt(5)), precision)
        
        let halfLength = calculateCurveLength(with: pointEvaluator, fromTime: 0, toTime: 0.5, precision: precision)
        XCTAssertLessThan(abs(halfLength - sqrt(5) / 2), precision)
    }
    
    func testCalculateCurveLengthWithHalfCircleCurve() {
        let pointEvaluator: Curve.PointEvaluator = { time in
            return CGPoint(x: cos(time * .pi), y: sin(time * .pi))
        }
        
        let precision: CGFloat = 0.01
        
        let totalLength = calculateCurveLength(with: pointEvaluator, fromTime: 0, toTime: 1, precision: precision)
        XCTAssertLessThan(abs(totalLength - .pi), precision)
        
        let halfLength = calculateCurveLength(with: pointEvaluator, fromTime: 0, toTime: 0.5, precision: precision)
        XCTAssertLessThan(abs(halfLength - .pi / 2), precision)
    }
    
    func testCalculateCurveLengthPerformance() {
        let pointEvaluator: Curve.PointEvaluator = { time in
            return CGPoint(x: cos(time * .pi), y: sin(time * .pi))
        }
        
        measure {
            _ = calculateCurveLength(with: pointEvaluator, fromTime: 0, toTime: 1, precision: 0.01)
        }
    }
}
