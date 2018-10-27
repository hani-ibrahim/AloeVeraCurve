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
            let x = progress * (containerView.frame.width - circleView.frame.width)
            let y = curve(x)
            circleView.transform = CGAffineTransform(translationX: x, y: y)
        }
        progressLabel.text = String(format: "%.2f", progress)
    }
    
    func makeCurve() -> (CGFloat) -> CGFloat {
        switch example! {
        case .linear: return makeLinearCurve()
        }
    }
    
    func makeLinearCurve() -> (CGFloat) -> CGFloat {
        return { _ in
            return 100
        }
    }
}
