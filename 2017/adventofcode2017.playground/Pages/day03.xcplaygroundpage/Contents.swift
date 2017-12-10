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
    let sideIndex = index % size
    return abs(sideIndex - layer)
}

func layerOfNumber(_ input: Int) -> Int {
    let maxSqrt = upperBoundingOddSquareRoot(input)
    return maxSqrt / 2
}

func positionAroundLayer(_ input: Int) -> Int {
    let minSqrt = lowerBoundingOddSquareRoot(input)
    return input - (minSqrt * minSqrt) // how far around the ring on its layer is the number?
}

func stepsToAccessPoint(_ input: Int) -> Int {
    guard input > 1 else { return 0 }

    let position = positionAroundLayer(input)
    let layer = layerOfNumber(input)
    return layer + distanceFromCenter(position, layer: layer)
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

//: Part 2
// This is incredibly gross but it works

func sumOfNumbers(in matrix: [[Int]], around point: (x: Int, y: Int)) -> Int {
    return matrix[point.x + 1][point.y + 1]
        +  matrix[point.x + 1][point.y]
        +  matrix[point.x + 1][point.y - 1]
        +  matrix[point.x]    [point.y - 1]
        +  matrix[point.x]    [point.y + 1]
        +  matrix[point.x - 1][point.y + 1]
        +  matrix[point.x - 1][point.y]
        +  matrix[point.x - 1][point.y - 1]
}

func firstLarger(than input: Int) -> Int {
    let size = layerOfNumber(input) * 2 + 1

    var matrix = Array(repeating: Array(repeating: 0, count: size), count: size)
    let middleX = size / 2 + 1
    let middleY = middleX

    matrix[middleX][middleY] = 1
    var current = matrix[middleX][middleY]
    var posX = middleX + 1
    var posY = middleY

    var layer = 1
    while current < input {
        let distance = layer * 2
        // move up
        for _ in 1...(distance-1) {
            current = sumOfNumbers(in: matrix, around: (posX, posY))
            matrix[posX][posY] = current
            if current >= input { return current }
            posY -= 1
        }
        // move left
        for _ in 1...distance {
            current = sumOfNumbers(in: matrix, around: (posX, posY))
            matrix[posX][posY] = current
            if current >= input { return current }
            posX -= 1
        }
        // move down
        for _ in 1...distance {
            current = sumOfNumbers(in: matrix, around: (posX, posY))
            matrix[posX][posY] = current
            if current >= input { return current }
            posY += 1
        }
        // move right
        for _ in 1...(distance+1) {
            current = sumOfNumbers(in: matrix, around: (posX, posY))
            matrix[posX][posY] = current
            if current >= input { return current }
            posX += 1
        }
        layer += 1
    }
    return current
}

firstLarger(than: 289326)
