//
//  Curve.swift
//  CurveExample
//
//  Created by Hani on 27.10.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit

enum SampleCurve: String, CaseIterable {
    case linearBezierCurve
    case quadraticBezierCurve
    case cubicBezierCurve
    case arc
    case parabola
}

extension SampleCurve {
    var title: String {
        return rawValue.titlecased()
    }
}

enum SamplePolynomialCurve: String, CaseIterable {
    case line
    case parabola
}

extension SamplePolynomialCurve {
    var title: String {
        return rawValue.titlecased()
    }
}

private extension String {
    func titlecased() -> String {
        return replacingOccurrences(of: "([A-Z])", with: " $1", options: .regularExpression, range: range(of: self))
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalized
    }
}
