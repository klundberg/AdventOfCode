//: [Day 4](http://adventofcode.com/2017/day/4) - [Previous](@previous) - [Next](@next)
//: Part 1
import Foundation

// See Sources/Passphrases.swift for input variable `passphrases`

func isValidPhrase(_ phrase: [String]) -> Bool {
    let set = Set(phrase)
    return set.count == phrase.count
}

func validPhrases(in list: [[String]]) -> [[String]] {
    return list.filter(isValidPhrase(_:))
}

validPhrases(in: passphrases).count

//: Part 2

func sortedLettersInWords(in phrases: [[String]]) -> [[String]] {
    return phrases.map({ phrase in
        phrase.map({ word in
            String(word.sorted())
        })
    })
}

validPhrases(in: sortedLettersInWords(in: passphrases)).count

