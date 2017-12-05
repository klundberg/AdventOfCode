//: [Day 4](http://adventofcode.com/2017/day/4) - [Previous](@previous) - [Next](@next)
//: Part 1
import Foundation

// See Sources/Passphrases.swift for input variable `passphrases`

func isValidPhrase(_ phrase: [String]) -> Bool {
    return Set(phrase).count == phrase.count
}

func validPhrases(in list: [[String]]) -> [[String]] {
    return list.filter(isValidPhrase(_:))
}

validPhrases(in: passphrases).count

//: Part 2
func sortedLettersInWords(in list: [[String]]) -> [[String]] {
    return list.map({ phrase in
        phrase.map({ String($0.sorted()) })
    })
}

validPhrases(in: sortedLettersInWords(in: passphrases)).count

