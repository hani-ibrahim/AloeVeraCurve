//
//  DrawingViewController.swift
//  CurveExample
//
//  Created by Hani on 27.10.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit
import AloeVeraCurve

final class DrawingViewController: UIViewController {
    
    var sampleCurve: SampleCurve!
    
    private var curve: Curve!
    private var shouldConfigureView = true
    private let pathLayer = CAShapeLayer()
    
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var circleView: UIView!
    @IBOutlet private var lengthLabel: UILabel!
    @IBOutlet private var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = sampleCurve.title
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        shouldConfigureView = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard shouldConfigureView else {
            return
        }
        
        configureCurve(size: containerView.frame.size)
        configurePath()
        updateLength()
        updateCircle(forProgress: 0)
    }
    
    @IBAction private func sliderValueChanged(slider: UISlider) {
        updateCircle(forProgress: CGFloat(slider.value))
    }
}

private extension DrawingViewController {
    func configureCurve(size: CGSize) {
        switch sampleCurve! {
        case .linearBezierCurve:
            curve = try! linearBezierCurve(withStartPoint: CGPoint(x: 0, y: size.height),
                                           endPoint: CGPoint(x: size.width, y: 0))
        case .quadraticBezierCurve:
            curve = try! quadraticBezierCurve(withStartPoint: CGPoint(x: 0, y: size.height),
                                              controlPoint: CGPoint(x: size.width, y: size.height),
                                              endPoint: CGPoint(x: size.width, y: 0))
        case .cubicBezierCurve:
            curve = try! cubicBezierCurve(withStartPoint: CGPoint(x: 0, y: size.height),
                                          controlPoint1: CGPoint(x: size.width / 4, y: -size.height),
                                          controlPoint2: CGPoint(x: size.width * 3 / 4, y: size.height * 2),
                                          endPoint: CGPoint(x: size.width, y: 0))
        case .arc:
            curve = arcCurve(withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                             radius: size.width / 3,
                             startAngle: 0, endAngle: .pi * 3 / 2,
                             clockwise: true)
        case .parabola:
            curve = try! parabolaCurve(startPoint: CGPoint(x: 0, y: 0),
                                       vertexYPosition: size.height,
                                       endPoint: CGPoint(x: size.width, y: 0))
        }
    }
    
    func configurePath() {
        pathLayer.frame = containerView.bounds
        pathLayer.backgroundColor = UIColor.clear.cgColor
        pathLayer.path = curve.makeCGPath()
        pathLayer.lineWidth = 1
        pathLayer.strokeColor = UIColor.black.withAlphaComponent(0.1).cgColor
        pathLayer.fillColor = UIColor.clear.cgColor
        containerView.layer.addSublayer(pathLayer)
    }
    
    func updateLength() {
        let length = curve.calculateLength(fromTime: 0, toTime: 1)
        lengthLabel.text = String(format: "Curve Length: %.2f pt", length)
    }
    
    func updateCircle(forProgress progress: CGFloat) {
        let position = curve.evaluatePoint(atTime: progress)
        circleView.transform = CGAffineTransform(translationX: position.x, y: position.y)
        progressLabel.text = String(format: "Progress: %.f %%", progress * 100)
    }
}
