//
//  Curve.swift
//  AloeVeraCurve
//
//  Created by Hani on 27.10.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit

enum Curve: String, CaseIterable {
    case line
    case parabola
    case arc
    case linearBezierCurve
    case quadraticBezierCurve
    case cubicBezierCurve
}

extension Curve {
    var title: String {
        return rawValue.titlecased()
    }
    
    var isTimeFunction: Bool {
        switch self {
        case .line: return false
        case .parabola: return false
        case .arc: return true
        case .linearBezierCurve: return true
        case .quadraticBezierCurve: return true
        case .cubicBezierCurve: return true
        }
    }
}

private extension String {
    func titlecased() -> String {
        return replacingOccurrences(of: "([A-Z])", with: " $1", options: .regularExpression, range: range(of: self))
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalized
    }
}
