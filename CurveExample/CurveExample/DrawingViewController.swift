//
//  DrawingViewController.swift
//  AloeVeraCurve
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
        
        let playground = Playground(size: containerView.frame.size)
        curve = playground.makeCurve(for: sampleCurve)
        configurePath()
        updateCircle(forProgress: 0)
        updateLength()
    }
    
    @IBAction private func sliderValueChanged(slider: UISlider) {
        updateCircle(forProgress: CGFloat(slider.value))
    }
}

private extension DrawingViewController {
    func updateCircle(forProgress progress: CGFloat) {
        let position = curve.evaluatePoint(atTime: progress)
        circleView.transform = CGAffineTransform(translationX: position.x, y: position.y)
        progressLabel.text = String(format: "Progress: %.f %%", progress * 100)
    }
    
    func updateLength() {
        let length = curve.calculateLength(fromTime: 0, toTime: 1)
        lengthLabel.text = String(format: "Curve Length: %.2f pt", length)
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
}
