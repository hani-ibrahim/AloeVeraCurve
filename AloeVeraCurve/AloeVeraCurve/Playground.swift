//
//  Playground.swift
//  AloeVeraCurve
//
//  Created by Hani on 27.10.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit

struct Playground {
    
    private let size: CGSize
    
    init(size: CGSize) {
        self.size = size
    }
    
    func makeCurveFunction(for curve: Curve) -> (CGFloat) -> CGPoint {
        switch curve {
        case .line: return wrapNonPointFunction(makeLineCurve())
        case .parabola: return wrapNonPointFunction(makeParabolaCurve())
        case .arc: return makeArcCurve()
        case .linearBezierCurve: return makeLinearBezierCurve()
        case .quadraticBezierCurve: return makeQuadraticBezierCurve()
        case .cubicBezierCurve: return makeCubicBezierCurve()
        }
    }
    
    func makePath(for curve: Curve, precision: CGFloat) -> CGPath {
        let curveFunction = makeCurveFunction(for: curve)
        
        let path = CGMutablePath()
        path.move(to: curveFunction(0))
        
        var progress: CGFloat = precision
        while progress <= 1 {
            path.addLine(to: curveFunction(progress))
            progress += precision
        }
        return path
    }
}

private extension Playground {
    func wrapNonPointFunction(_ function: @escaping (CGFloat) -> CGFloat) -> (CGFloat) -> CGPoint {
        let width = size.width
        return { progress in
            let x = progress * width
            return CGPoint(x: x, y: function(x))
        }
    }
    
    func makeLineCurve() -> (CGFloat) -> CGFloat {
        return try! lineCurveFor(point1: CGPoint(x: 0, y: size.height),
                                 point2: CGPoint(x: size.width, y: 0))
    }
    
    func makeParabolaCurve() -> (CGFloat) -> CGFloat {
        return try! parabolaCurveFor(point1: CGPoint(x: 0, y: 0),
                                     point2: CGPoint(x: size.width / 2, y: size.height),
                                     point3: CGPoint(x: size.width, y: 0))
    }
    
    func makeArcCurve() -> (CGFloat) -> CGPoint {
        return arcCurve(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                        radius: size.width / 3,
                        startAngle: 0, endAngle: .pi * 3 / 2)
    }
    
    func makeLinearBezierCurve() -> (CGFloat) -> CGPoint {
        return try! linearBezierCurve(withStartPoint: CGPoint(x: 0, y: size.height),
                                      endPoint: CGPoint(x: size.width, y: 0))
    }
    
    func makeQuadraticBezierCurve() -> (CGFloat) -> CGPoint {
        return try! quadraticBezierCurve(withStartPoint: CGPoint(x: 0, y: size.height),
                                         controlPoint: CGPoint(x: size.width, y: size.height),
                                         endPoint: CGPoint(x: size.width, y: 0))
    }
    
    func makeCubicBezierCurve() -> (CGFloat) -> CGPoint {
        return try! cubicBezierCurve(withStartPoint: CGPoint(x: 0, y: size.height),
                                     controlPoint1: CGPoint(x: size.width / 4, y: -size.height),
                                     controlPoint2: CGPoint(x: size.width * 3 / 4, y: size.height * 2),
                                     endPoint: CGPoint(x: size.width, y: 0))
    }
}
