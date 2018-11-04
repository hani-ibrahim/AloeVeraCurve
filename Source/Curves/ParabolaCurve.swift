//
//  ParabolaCurve.swift
//  AloeVeraCurve
//
//  Created by Hani on 03.11.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit

/// Parabola Curve
///
/// - Parameters:
///   - startPoint: start point on the parabola
///   - vertexYPosition: y-position of the vertex of the parabola, the x will be in the middle of the start and end points
///   - endPoint: end point on the parabola
/// - Returns: `Curve`
/// - Throws:
///   - unsupported: if the `startPoint` & `endPoint` doesn't have the same `Y` value
///   - unsupported: if the `vertex` has the same value as the `Y` of `startPoint` & `endPoint`
///   - unsupported: if the `X` of the `endPoint` is smaller than `X` of the `startPoint`
public func parabolaCurve(startPoint: CGPoint, vertexYPosition: CGFloat, endPoint: CGPoint) throws -> Curve {
    guard startPoint.y == endPoint.y && vertexYPosition != startPoint.y, endPoint.x > startPoint.x else {
        throw CurveError.unsupported
    }
    
    let vertex = CGPoint(x: (startPoint.x + endPoint.x) / 2, y: vertexYPosition)
    let controlPoint = CGPoint(x: vertex.x, y: vertex.y * 2 - startPoint.y)
    
    return try quadraticBezierCurve(withStartPoint: startPoint, controlPoint: controlPoint, endPoint: endPoint)
}
