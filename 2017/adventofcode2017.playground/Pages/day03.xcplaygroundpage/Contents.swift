//: [Day 3](http://adventofcode.com/2017/day/3) - [Previous](@previous) - [Next](@next)

import Foundation

// 1^2, 3^2, 5^2, ...

func upperBoundingOddSquareRoot(_ input: Int) -> Int {
    let maxSqrt = Int(ceil(Double(input).squareRoot()))
    if maxSqrt % 2 == 0 {
        return maxSqrt + 1
    }
    return maxSqrt
}

func lowerBoundingOddSquareRoot(_ input: Int) -> Int {
    let minSqrt = Int(floor(Double(input).squareRoot()))
    if minSqrt % 2 == 0 {
        return minSqrt - 1
    }
    return minSqrt
}

func distanceFromCenter(_ index: Int, layer: Int) -> Int {
    let size = layer * 2

    var sideIndex = index
    while sideIndex >= size {
        sideIndex -= size
    }

    return abs(sideIndex - layer)
}

func stepsToAccessPoint(_ input: Int) -> Int {
    guard input > 1 else { return 0 }
    let minSqrt = lowerBoundingOddSquareRoot(input)
    let maxSqrt = upperBoundingOddSquareRoot(input)

    let layer = maxSqrt / 2
    let positionAroundLayer = input - (minSqrt * minSqrt) // how far around the ring is the number?

    return layer + distanceFromCenter(positionAroundLayer, layer: layer)
}


// 1  2  3  4  5  6 - 7  8  9  10 11 12 - 13 14 15 16 17 18 -
// 2  1  0  1  2  3 - 2  1  0  1  2  3  - 2  1  0  1  2  3  -
let a = Array(0...24).map({ distanceFromCenter($0, layer: 3) })
a

(2...9).map(stepsToAccessPoint)
(10...25).map(stepsToAccessPoint)
stepsToAccessPoint(1)
stepsToAccessPoint(12)
stepsToAccessPoint(23)
stepsToAccessPoint(1024)

stepsToAccessPoint(289326)

