//
//  Copyright © 2024 Hani. All rights reserved.
//

public struct CurvePoint {
    public let input: CGFloat
    public let output: CGFloat
    
    public init(input: CGFloat, output: CGFloat) {
        self.input = input
        self.output = output
    }
}

extension CurvePoint {
    var cgPoint: CGPoint {
        CGPoint(x: input, y: output)
    }
}
