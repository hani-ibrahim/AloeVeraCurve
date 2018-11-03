//
//  Playground.swift
//  AloeVeraCurve
//
//  Created by Hani on 27.10.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit
import AloeVeraCurve

struct Playground {
    
    private let size: CGSize
    
    init(size: CGSize) {
        self.size = size
    }
    
    func makeCurve(for curve: SampleCurve) -> Curve {
        switch curve {
        case .linearBezierCurve: return makeLinearBezierCurve()
        case .quadraticBezierCurve: return makeQuadraticBezierCurve()
        case .cubicBezierCurve: return makeCubicBezierCurve()
        case .arc: return makeArcCurve()
        case .parabola: return makeParabolaCurve()
        }
    }
}

private extension Playground {
    func makeLinearBezierCurve() -> Curve {
        return try! linearBezierCurve(withStartPoint: CGPoint(x: 0, y: size.height),
                                      endPoint: CGPoint(x: size.width, y: 0))
    }
    
    func makeQuadraticBezierCurve() -> Curve {
        return try! quadraticBezierCurve(withStartPoint: CGPoint(x: 0, y: size.height),
                                         controlPoint: CGPoint(x: size.width, y: size.height),
                                         endPoint: CGPoint(x: size.width, y: 0))
    }
    
    func makeCubicBezierCurve() -> Curve {
        return try! cubicBezierCurve(withStartPoint: CGPoint(x: 0, y: size.height),
                                     controlPoint1: CGPoint(x: size.width / 4, y: -size.height),
                                     controlPoint2: CGPoint(x: size.width * 3 / 4, y: size.height * 2),
                                     endPoint: CGPoint(x: size.width, y: 0))
    }
    
    func makeArcCurve() -> Curve {
        return arcCurve(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                        radius: size.width / 3,
                        startAngle: 0, endAngle: .pi * 3 / 2,
                        clockwise: true)
    }
    
    func makeParabolaCurve() -> Curve {
        return try! parabolaCurve(startPoint: CGPoint(x: 0, y: 0),
                                  vertexYPosition: size.height,
                                  endPoint: CGPoint(x: size.width, y: 0))
    }
}
