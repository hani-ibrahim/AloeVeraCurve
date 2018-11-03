//
//  BezierCurvesTests.swift
//  AloeVeraCurveTests
//
//  Created by Hani on 03.11.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import XCTest
import AloeVeraCurve

final class BezierCurvesTests: XCTestCase {

    func testLinearCurve() {
        let curve = try! linearBezierCurve(withStartPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 10, y: 10))
        
        XCTAssertEqual(curve.evaluatePoint(atTime: 0), CGPoint(x: 0, y: 0))
        XCTAssertEqual(curve.evaluatePoint(atTime: 0.5), CGPoint(x: 5, y: 5))
        XCTAssertEqual(curve.evaluatePoint(atTime: 1), CGPoint(x: 10, y: 10))
        
        XCTAssertEqual(curve.calculateLength(fromTime: 0, toTime: 1), sqrt(200))
        XCTAssertEqual(curve.calculateLength(fromTime: 0.25, toTime: 0.75), sqrt(50))
    }
}
