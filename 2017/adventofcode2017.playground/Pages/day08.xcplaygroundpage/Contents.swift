//: [Day 8](http://adventofcode.com/2017/day/8) - [Previous](@previous) - [Next](@next)

import Foundation

struct Instruction {
    var register: String
    var operation: (Int, Int) -> Int
    var amount: Int

    var comparisonRegister: String
    var comparison: (Int, Int) -> Bool
    var comparisonAmount: Int

    func execute(using memory: inout [String: Int]) {
        let comparisonValue = memory[comparisonRegister, default: 0]
        if comparison(comparisonValue, comparisonAmount) {
            memory[register] = operation(memory[register, default: 0], amount)
        }
    }
}

func operation(for token: Substring) -> (Int, Int) -> Int {
    switch token {
    case "dec": return (-)
    case "inc": return (+)
    default: fatalError()
    }
}

func comparison(for token: Substring) -> (Int, Int) -> Bool {
    switch token {
    case "==": return (==)
    case "!=": return (!=)
    case "<": return (<)
    case "<=": return (<=)
    case ">": return (>)
    case ">=": return (>=)
    default: fatalError()
    }
}

func parseProgram(_ input: String) -> [Instruction] {
    let lines = input.split(separator: "\n")

    return lines.map({ (substr) -> Instruction in
        let tokens = substr.split(separator: " ")

        return Instruction(register: String(tokens[0]),
                           operation: operation(for: tokens[1]),
                           amount: Int(tokens[2])!,
                           comparisonRegister: String(tokens[4]),
                           comparison: comparison(for: tokens[5]),
                           comparisonAmount: Int(tokens[6])!)
    })
}

func executeProgram(_ instructions: [Instruction]) -> [String: Int] {
    var memory: [String: Int] = [:]

    for instruction in instructions {
        instruction.execute(using: &memory)
    }

    return memory
}

let program = parseProgram(input)
let resultMemory = executeProgram(program)

resultMemory.values.max()

// part 2
func highestValueFromExecutingProgram(_ instructions: [Instruction]) -> Int {
    var memory: [String: Int] = [:]
    var maxVal = Int.min
    for instruction in instructions {
        instruction.execute(using: &memory)
        maxVal = max(maxVal, memory.values.max()!)
    }

    return maxVal
}

highestValueFromExecutingProgram(program)
