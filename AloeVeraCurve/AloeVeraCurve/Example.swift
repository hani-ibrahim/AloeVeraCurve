//
//  Example.swift
//  AloeVeraCurve
//
//  Created by Hani on 27.10.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit

enum Example: String, CaseIterable {
    case linear
    case quadratic
    case linearBezierCurve
    case quadraticBezierCurve
}

extension Example {
    var title: String {
        return rawValue.capitalized
    }
    
    var isTimeFunction: Bool {
        switch self {
        case .linear: return false
        case .quadratic: return false
        case .linearBezierCurve: return true
        case .quadraticBezierCurve: return true
        }
    }
}
