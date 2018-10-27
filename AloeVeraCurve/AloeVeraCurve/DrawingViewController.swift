//
//  DrawingViewController.swift
//  AloeVeraCurve
//
//  Created by Hani on 27.10.18.
//  Copyright © 2018 Hani. All rights reserved.
//

import UIKit

final class DrawingViewController: UIViewController {
    
    var curve: Curve!
    
    private var curveFunction: ((CGFloat) -> CGPoint)!
    private var shouldConfigureView = true
    private let pathLayer = CAShapeLayer()
    
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var circleView: UIView!
    @IBOutlet private var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = curve.title
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
        configure(path: playground.makePath(for: curve, precision: 0.001))
        curveFunction = playground.makeCurveFunction(for: curve)
        updateCircle(forProgress: 0)
    }
    
    @IBAction private func sliderValueChanged(slider: UISlider) {
        updateCircle(forProgress: CGFloat(slider.value))
    }
}

private extension DrawingViewController {
    func updateCircle(forProgress progress: CGFloat) {
        let position = curveFunction(progress)
        circleView.transform = CGAffineTransform(translationX: position.x, y: position.y)
        
        let input = curve.isTimeFunction ? progress * 100 : progress * containerView.frame.width
        let unit = curve.isTimeFunction ? "%" : "pt"
        progressLabel.text = String(format: "%.f %@", input, unit)
    }
    
    func configure(path: CGPath) {
        pathLayer.frame = containerView.bounds
        pathLayer.backgroundColor = UIColor.clear.cgColor
        pathLayer.path = path
        pathLayer.lineWidth = 1
        pathLayer.strokeColor = UIColor.black.withAlphaComponent(0.1).cgColor
        pathLayer.fillColor = UIColor.clear.cgColor
        containerView.layer.addSublayer(pathLayer)
    }
}
