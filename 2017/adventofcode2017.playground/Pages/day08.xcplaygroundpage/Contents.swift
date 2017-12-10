//: [Day 8](http://adventofcode.com/2017/day/8) - [Previous](@previous) - [Next](@next)

import Foundation

struct Instruction {
    var register: String
    var operation: (Int, Int) -> Int
    var amount: Int

    var comparisonRegister: String
    var comparison: (Int, Int) -> Bool
    var comparisonAmount: Int
}


