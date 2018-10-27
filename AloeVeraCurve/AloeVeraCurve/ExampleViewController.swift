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
    
    private var curve: ((CGFloat) -> CGFloat)!
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
        if example.isTimeFunction {
            
        } else {
            let x = progress * playgroundSize.width
            let y = curve(x)
            circleView.transform = CGAffineTransform(translationX: x, y: y)
        }
        progressLabel.text = String(format: "%.2f", progress)
    }
    
    func calculatePlaygroundSize() -> CGSize {
        return CGSize(width: containerView.frame.width - circleView.frame.width,
                      height: containerView.frame.height - circleView.frame.height)
    }
    
    func makeCurve() -> (CGFloat) -> CGFloat {
        switch example! {
        case .linear: return makeLineCurve()
        case .quadratic: return makeParabolaCurve()
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
}
