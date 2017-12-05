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
// This is unfinished, may revisit later

func numbersAdjacentToNumber(at index: Int, in grid: [[Int]]) -> [Int] {
    let layer = layerOfNumber(index)
    let previousLayer = layer - 1
    let position = positionAroundLayer(index)
    let previousPosition = position - 1


    return []
}

func firstLarger(_ input: Int) -> Int {
    var grid: [[Int]] = []

    grid.insert([1], at: 0)

    var index = 1
    var currentNumber = 1
    while currentNumber <= input {
        let position = positionAroundLayer(index)
        let layer = layerOfNumber(index)

    }

    return currentNumber
}


//firstLarger(289326)



/*
 147  142  133  122   59
 304    5    4    2   57
 330   10    1    1   54
 351   11   23   25   26
 362  747  806--->   ...

 indexes:          positions around each layer:
 17 16 15 14 13    08 07 06 05 04
 18 5  4  3  12    09 04 03 02 03
 19 6  1  2  11    10 05 01 01 02
 20 7  8  9  10    11 06 07 08 01
 21 22 23 24 25    12 13 14 15 16

 if corner:
   add numbers at (layer n, pos -1), (layer n-1, pos / 2), (layer n, pos+1 % layerSize)
 if side:
   add numbers at (layer n, pos - 1), (layer n-1, pos /2,

 1 = []

 2 = [1]
 3 = [1, 2]
 4 = [1, 2, 3]
 5 = [1, 4]
 6 = [1, 4, 5]
 7 = [1, 6]
 8 = [1, 6, 7]
 9 = [1, 8, 2]

 10 = [9, 2]
 11 = [9, 2, 3, 10]
 12 = [2, 3, 11]
 13 = [3, 12]
 14 = [3, 12, 13]
 15 = [3, 4, 5, 14]
 16 = [4, 5, 15]
 17 = [5, 16]
 ...

1
1  2  4  5  10 11 23 25
0  1  3  4  9  10 22 24

 26 54 57 59 122 133 142 147 304 330 351 362 747 806 831 857

 */



