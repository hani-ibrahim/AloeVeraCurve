//
//  AnimationViewController.swift
//  CurveExample
//
//  Created by Hani on 03.11.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit
import AloeVeraCurve

final class AnimationViewController: UIViewController {
    
    var sampleCurve: SamplePolynomialCurve!
    
    private var positionCurve: ((CGFloat) -> CGFloat)!
    private var scaleCurve: ((CGFloat) -> CGFloat)!
    private var rotateCurve: ((CGFloat) -> CGFloat)!
    private var displayLinkIncreaseCurve: Curve!
    private var displayLinkDecreaseCurve: Curve!
    private var displayLink: CADisplayLink!
    private var startTime = 0.0
    private let speed = 0.5
    
    @IBOutlet private var label: UILabel!
    @IBOutlet private var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = sampleCurve.title
        configureCurve()
        updateLabel(forProgress: 0)
        configureDisplayLink()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        displayLink.invalidate()
    }
    
    @IBAction private func sliderValueChanged(slider: UISlider) {
        displayLink.invalidate()
        updateLabel(forProgress: CGFloat(slider.value))
    }
}

private extension AnimationViewController {
    func configureCurve() {
        switch sampleCurve! {
        case .line:
            positionCurve = try! polynomialLineCurveFor(point1: CGPoint(x: 0, y: 0),
                                                        point2: CGPoint(x: 1, y: 200))
            scaleCurve = try! polynomialLineCurveFor(point1: CGPoint(x: 0, y: 1),
                                                     point2: CGPoint(x: 1, y: 2))
            rotateCurve = try! polynomialLineCurveFor(point1: CGPoint(x: 0, y: -CGFloat.pi),
                                                      point2: CGPoint(x: 1, y: 0))
        case .parabola:
            positionCurve = try! polynomialParabolaCurveFor(point1: CGPoint(x: 0, y: 0),
                                                            point2: CGPoint(x: 0.5, y: 200),
                                                            point3: CGPoint(x: 1, y: 0))
            scaleCurve = try! polynomialParabolaCurveFor(point1: CGPoint(x: 0, y: 1),
                                                         point2: CGPoint(x: 0.5, y: 2),
                                                         point3: CGPoint(x: 1, y: 1))
            rotateCurve = try! polynomialParabolaCurveFor(point1: CGPoint(x: 0, y: -CGFloat.pi),
                                                          point2: CGPoint(x: 0.5, y: 0),
                                                          point3: CGPoint(x: 1, y: -CGFloat.pi))
        }
    }
    
    func updateLabel(forProgress progress: CGFloat) {
        let position = positionCurve(progress)
        let scale = scaleCurve(progress)
        let rotate = rotateCurve(progress)
        
        label.transform = CGAffineTransform(translationX: 0, y: position)
                            .scaledBy(x: scale, y: scale)
                            .rotated(by: rotate)
    }
    
    func configureDisplayLink() {
        startTime = CACurrentMediaTime()
        displayLink = CADisplayLink(target: self, selector: #selector(displayLinkRunLoop))
        displayLink.add(to: .main, forMode: .common)
        displayLinkIncreaseCurve = try! cubicBezierCurve(withStartPoint: CGPoint(x: 0, y: 0),
                                                         controlPoint1: CGPoint(x: 0.5, y: 0),
                                                         controlPoint2: CGPoint(x: 0.5, y: 1),
                                                         endPoint: CGPoint(x: 1, y: 1))
        displayLinkDecreaseCurve = try! cubicBezierCurve(withStartPoint: CGPoint(x: 0, y: 1),
                                                         controlPoint1: CGPoint(x: 0.5, y: 1),
                                                         controlPoint2: CGPoint(x: 0.5, y: 0),
                                                         endPoint: CGPoint(x: 1, y: 0))
    }
    
    @objc func displayLinkRunLoop() {
        let duration = (CACurrentMediaTime() - startTime) * speed
        let progress = CGFloat(duration.truncatingRemainder(dividingBy: 1))
        
        // Creating Ease-In-Out curve by spliting the animation into two cubicBezierCurve
        let isIncreasing = floor(duration).truncatingRemainder(dividingBy: 2) == 0
        let curve = isIncreasing ? displayLinkIncreaseCurve : displayLinkDecreaseCurve
        
        let curveProgress = curve!.evaluatePoint(atTime: progress).y
        updateLabel(forProgress: curveProgress)
        slider.value = Float(curveProgress)
    }
}
