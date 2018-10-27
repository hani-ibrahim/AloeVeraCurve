//
//  ExampleViewController.swift
//  AloeVeraCurve
//
//  Created by Hani on 27.10.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit

final class ExampleViewController: UIViewController {
    
    var example: Example!
    
    private var curve: ((CGFloat) -> CGPoint)!
    private var viewBounds: CGRect = .zero
    private var playgroundSize: CGSize = .zero
    
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var circleView: UIView!
    @IBOutlet private var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = example.rawValue
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if viewBounds != view.bounds {
            viewBounds = view.bounds
            
            playgroundSize = calculatePlaygroundSize()
            curve = makeCurve()
            updateCircle(forProgress: 0)
        }
    }
    
    @IBAction private func sliderValueChanged(slider: UISlider) {
        updateCircle(forProgress: CGFloat(slider.value))
    }
}

private extension ExampleViewController {
    func updateCircle(forProgress progress: CGFloat) {
        let input: CGFloat
        let readableInput: CGFloat
        let unit: String
        if example.isTimeFunction {
            input = progress
            readableInput = input * 100
            unit = "%"
        } else {
            input = progress * playgroundSize.width
            readableInput = input
            unit = "pt"
        }
        
        let position = curve(input)
        circleView.transform = CGAffineTransform(translationX: position.x, y: position.y)
        progressLabel.text = String(format: "%.f %@", readableInput, unit)
    }
    
    func calculatePlaygroundSize() -> CGSize {
        return CGSize(width: containerView.frame.width - circleView.frame.width,
                      height: containerView.frame.height - circleView.frame.height)
    }
    
    func makeCurve() -> (CGFloat) -> CGPoint {
        switch example! {
        case .linear: return wrapNonPointFunction(makeLineCurve())
        case .quadratic: return wrapNonPointFunction(makeParabolaCurve())
        case .linearBezierCurve: return makeLinearBezierCurve()
        case .quadraticBezierCurve: return makeQuadraticBezierCurve()
        case .cubicBezierCurve: return makeCubicBezierCurve()
        }
    }
    
    func wrapNonPointFunction(_ function: @escaping (CGFloat) -> CGFloat) -> (CGFloat) -> CGPoint {
        return { x in
            return CGPoint(x: x, y: function(x))
        }
    }
    
    func makeLineCurve() -> (CGFloat) -> CGFloat {
        return try! lineCurveFor(point1: CGPoint(x: 0, y: playgroundSize.height),
                                 point2: CGPoint(x: playgroundSize.width, y: 0))
    }
    
    func makeParabolaCurve() -> (CGFloat) -> CGFloat {
        return try! parabolaCurveFor(point1: CGPoint(x: 0, y: 0),
                                     point2: CGPoint(x: playgroundSize.width / 2, y: playgroundSize.height),
                                     point3: CGPoint(x: playgroundSize.width, y: 0))
    }
    
    func makeLinearBezierCurve() -> (CGFloat) -> CGPoint {
        return try! linearBezierCurve(withStartPoint: CGPoint(x: 0, y: playgroundSize.height),
                                      endPoint: CGPoint(x: playgroundSize.width, y: 0))
    }
    
    func makeQuadraticBezierCurve() -> (CGFloat) -> CGPoint {
        return try! quadraticBezierCurve(withStartPoint: CGPoint(x: 0, y: playgroundSize.height),
                                         controlPoint: CGPoint(x: playgroundSize.width, y: playgroundSize.height),
                                         endPoint: CGPoint(x: playgroundSize.width, y: 0))
    }
    
    func makeCubicBezierCurve() -> (CGFloat) -> CGPoint {
        return try! cubicBezierCurve(withStartPoint: CGPoint(x: 0, y: playgroundSize.height),
                                     controlPoint1: CGPoint(x: playgroundSize.width / 4, y: -playgroundSize.height),
                                     controlPoint2: CGPoint(x: playgroundSize.width * 3 / 4, y: playgroundSize.height * 2),
                                     endPoint: CGPoint(x: playgroundSize.width, y: 0))
    }
}
