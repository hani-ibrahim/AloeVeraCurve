<p align="center">
<img width="500" height="500" src="Resources/AloeVera.jpg">
</p>

# **Contents**
- Curve
- Polynomial Curves
  - Line Curve
    - Practical Example
  - Parabola Curve
    - Practical Example
- Time Curves
  - Linear Beziér Curve
  - Quadratic Beziér Curve
  - Cubic Beziér Curve
  - Arc Curve
  - Parabola Curve

# **Curve**

`Curve` is a struct that has 3 main functions to help dealing with curves, it works on Time Curves where `X` & `Y` are both function in time
```swift
struct Curve {
    func evaluatePoint(atTime time: CGFloat) -> CGPoint
    func calculateLength(fromTime: CGFloat, toTime: CGFloat, withPrecision precision: CGFloat = 0.01) -> CGFloat
    func makeCGPath() -> CGPath
}
```

- `evaluatePoint`
  - Evaluate the CGPoint at the given time where t: 0...1
- `calculateLength`
  - Calculate length between two points on the curve where the two points defined by t: 0..1 and `fromTime < toTime`
- `makeCGPath`
  - Make CGPath object representing the whole curve that can be used to draw the curve on a CALayer

# **Polynomial Curves**

## **Line Curve**

Create a line curve function with any two points on it and get the `y` coordinate at any given `x`

<img width="300" height="300" src="Resources/line-curve.png">

```swift
let curve = try polynomialLineCurveFor(point1: CGPoint(x: 2, y: 0),
                                       point2: CGPoint(x: 7, y: 10))
print(curve(4)) // gives 4
print(curve(-1)) // gives -6
```

### Practical Example

Changing the position, scale and rotation of a label with a slider

<img width="600" height="300" src="Resources/line-curve.gif">

```swift
// Define the curves as instance variables
// `X` value define the slider progress from `0` to `1`, where `Y` is the value we need at that `X`
positionCurve = try polynomialLineCurveFor(point1: CGPoint(x: 0, y: 0), // Keep label at original position (at the start of the slider)
                                           point2: CGPoint(x: 1, y: 150)) // Move label 150 pt down (at the end of the slider)
scaleCurve = try polynomialLineCurveFor(point1: CGPoint(x: 0, y: 1), // Kepp label at original size (at the start of the slider)
                                        point2: CGPoint(x: 1, y: 2)) // Double the label size (at the end of the slider)
rotateCurve = try polynomialLineCurveFor(point1: CGPoint(x: 0, y: -CGFloat.pi), // Flip the label (at the start of the slider)
                                         point2: CGPoint(x: 1, y: 0)) // Revert label orientation to normal (at the end of the slider)

// Then in the `sliderValueChanged` function
let position = positionCurve(progress)
let scale = scaleCurve(progress)
let rotate = rotateCurve(progress)
        
label.transform = CGAffineTransform(translationX: 0, y: position)
                    .scaledBy(x: scale, y: scale)
                    .rotated(by: rotate) 
```

## **Parabola Curve**

Create a parabola curve function with any three points on it and get the `y` coordinate at any given `x`

<img width="300" height="300" src="Resources/parabola-curve.png">

```swift
let curve = try polynomialParabolaCurveFor(point1: CGPoint(x: 0, y: 0),
                                           point2: CGPoint(x: 6, y: 6), 
                                           point3: CGPoint(x: 8, y: 16))
print(curve(2)) // -2
print(curve(-2)) // 6
```

### Practical Example

Changing the position, scale and rotation of a label with a slider
**(Note that the label reach the maximum transform value in the middle of the slider and not at the end as in the line curve)**

<img width="600" height="300" src="Resources/parabola-curve.gif">

```swift
// Define the curves as instance variables
// `X` value define the slider progress from `0` to `1`, where `Y` is the value we need at that `X`
positionCurve = try polynomialParabolaCurveFor(point1: CGPoint(x: 0, y: 0), // Keep label at original position (at the start of the slider)
                                               point2: CGPoint(x: 0.5, y: 150), // Move label 150 pt down at (at 0.5 of the progress)
                                               point3: CGPoint(x: 1, y: 0)) // Return back label to original position (at the end of the slider)
scaleCurve = try polynomialParabolaCurveFor(point1: CGPoint(x: 0, y: 1), // Kepp label at original size (at the start of the slider)
                                            point2: CGPoint(x: 0.5, y: 2), // Double the label size (at 0.5 of the progress)
                                            point3: CGPoint(x: 1, y: 1)) // Return back label to original size (at the end of the slider)
rotateCurve = try polynomialParabolaCurveFor(point1: CGPoint(x: 0, y: -CGFloat.pi), // Flip the label (at the start of the slider)
                                             point2: CGPoint(x: 0.5, y: 0), // Revert label orientation to normal (at 0.5 of the progress)
                                             point3: CGPoint(x: 1, y: -CGFloat.pi)) // Flip the label again (at the end of the slider)

// Then in the `sliderValueChanged` function
let position = positionCurve(progress)
let scale = scaleCurve(progress)
let rotate = rotateCurve(progress)
        
label.transform = CGAffineTransform(translationX: 0, y: position)
                    .scaledBy(x: scale, y: scale)
                    .rotated(by: rotate)
```

# **Time Curves**

## **Linear Beziér Curve**

create a linear Beziér curve with a startPoint and endPoint

```swift
let curve = try linearBezierCurve(withStartPoint: CGPoint(x: 0, y: size.height),
                                  endPoint: CGPoint(x: size.width, y: 0))
```

## **Quadratic Beziér Curve**

## **Cubic Beziér Curve**

## **Arc Curve**

## **Parabola Curve**

